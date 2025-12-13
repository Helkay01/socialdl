<?php

declare(strict_types=1);

require __DIR__ . '/vendor/autoload.php';

use YoutubeDl\Options;
use YoutubeDl\YoutubeDl;

$yt = new YoutubeDl();
$videoUrl = 'https://www.youtube.com/watch?v=oDAw7vW7H0c';

try {
    $options = Options::create()
        ->skipDownload(true)               // Correct method for skipping download
        ->cookiesFromBrowser('chrome');    // Correct method for using browser cookies

    $collection = $yt->getDownloadInfo($videoUrl, $options);

    foreach ($collection->getVideos() as $video) {
        if ($video->getError()) {
            echo "Error retrieving video info: {$video->getError()}\n";
        } else {
            echo "Title: " . $video->getTitle() . "\n";
            echo "URL: " . $video->getUrl() . "\n";
            echo "Thumbnail: " . $video->getThumbnail() . "\n";
        }
    }
} catch (\YoutubeDl\Exception\YoutubeDlException $e) {
    echo "Failed to retrieve video info: " . $e->getMessage();
}
