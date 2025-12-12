<?php

declare(strict_types=1);

require __DIR__ . '/vendor/autoload.php';

use YoutubeDl\Options;
use YoutubeDl\YoutubeDl;

if (!isset($_GET['url'])) {
    die(json_encode([
        "error" => "Missing ?url= parameter"
    ]));
}

$videoUrl = $_GET['url'];

$yt = new YoutubeDl();

// Create options object
$options = Options::create();
$options->setUrl($videoUrl);
$options->setOption('skip-download', true); // do not save file
$options->setOption('dump-json', true);     // return full JSON metadata

$collection = $yt->download($options);

foreach ($collection->getVideos() as $video) {
    if ($video->getError()) {
        die(json_encode([
            "error" => $video->getError()
        ]));
    }

    $info = $video->getJson();

    // ------------------------
    // Extract Title
    // ------------------------
    $title = $info['title'] ?? null;

    // ------------------------
    // Extract Thumbnail
    // ------------------------
    $thumbnail = $info['thumbnail'] ?? null;

    // ------------------------
    // Extract Best Combined Video+Audio Direct URL
    // ------------------------
    $bestUrl = null;
    $bestHeight = 0;

    foreach ($info['formats'] as $f) {
        if (!isset($f['url'])) continue;

        $hasAudio = ($f['acodec'] ?? 'none') !== 'none';
        $hasVideo = ($f['vcodec'] ?? 'none') !== 'none';

        if ($hasAudio && $hasVideo) {
            $height = $f['height'] ?? 0;
            if ($height > $bestHeight) {
                $bestHeight = $height;
                $bestUrl = $f['url'];
            }
        }
    }

    // Fallback if no combined stream found
    if (!$bestUrl && isset($info['url'])) {
        $bestUrl = $info['url'];
    }

    header('Content-Type: application/json');
    echo json_encode([
        "title" => $title,
        "thumbnail" => $thumbnail,
        "direct_url" => $bestUrl
    ], JSON_PRETTY_PRINT);

    exit;
}
