<?php

declare(strict_types=1);

require __DIR__ . '/vendor/autoload.php';

use YoutubeDl\Options;
use YoutubeDl\YoutubeDl;

$yt = new YoutubeDl();

// The YouTube URL to fetch info for
$videoUrl = 'https://www.youtube.com/watch?v=oDAw7vW7H0c';

try {
    // Create options
    $options = Options::create()
        ->skipDownload(true)                  // Don't download video
        ->setOption('cookies-from-browser', 'chrome'); // Use browser cookies

    // Fetch video info
    $collection = $yt->getDownloadInfo($videoUrl, $options);

    foreach ($collection->getVideos() as $video) {
        if ($video->getError() !== null) {
            echo "Error retrieving video info: {$video->getError()}\n";
        } else {
            echo "Title: " . $video->getTitle() . "\n";
            echo "Link: " . $video->getUrl() . "\n";
            echo "Thumbnail: " . $video->getThumbnail() . "\n";
        }
    }
} catch (\YoutubeDl\Exception\YoutubeDlException $e) {
    echo "Failed to retrieve video info: " . $e->getMessage();
}
