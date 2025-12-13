<?php

declare(strict_types=1);

// URL of the YouTube video
$videoUrl = 'https://www.youtube.com/watch?v=oDAw7vW7H0c';

// Path to yt-dlp binary
$ytDlpPath = '/usr/local/bin/yt-dlp'; // adjust this to your yt-dlp path

// Command to get JSON info about the video
$cmd = escapeshellcmd("$ytDlpPath -j $videoUrl");

// Execute the command and capture output
$output = shell_exec($cmd);

if ($output === null) {
    die("Failed to execute yt-dlp.\n");
}

// Decode JSON output
$data = json_decode($output, true);

if (json_last_error() !== JSON_ERROR_NONE) {
    die("Failed to parse JSON: " . json_last_error_msg() . "\n");
}

// Extract needed information
$title = $data['title'] ?? 'N/A';
$thumbnail = $data['thumbnail'] ?? 'N/A';
$webpageUrl = $data['webpage_url'] ?? $videoUrl;

// Output
echo "Title: $title\n";
echo "URL: $webpageUrl\n";
echo "Thumbnail: $thumbnail\n";
