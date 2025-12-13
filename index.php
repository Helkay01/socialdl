<?php

declare(strict_types=1);

require __DIR__ . '/vendor/autoload.php';

use YoutubeDl\Options;
use YoutubeDl\YoutubeDl;

$yt = new YoutubeDl();

// Set options to skip actual download
$collection = $yt->download(
    Options::create()
        ->url('https://www.youtube.com/watch?v=oDAw7vW7H0c')
        ->skipDownload(true)
);

foreach ($collection->getVideos() as $video) {
    if ($video->getError() !== null) {
        echo "Error retrieving video info: {$video->getError()}.\n";
    } else {
        echo "Title: " . $video->getTitle() . "\n";
        echo "Link: " . $video->getUrl() . "\n";
        echo "Thumbnail: " . $video->getThumbnail() . "\n";
        echo "-----------------------------\n";
    }
}
