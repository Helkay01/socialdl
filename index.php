<?php
/**
 * Get YouTube video/audio links via yt-dlp (no cookies)
 */

function getYoutubeLinks($url) {
    // Base command
    $cmd = "yt-dlp -f bestvideo+bestaudio -g " . escapeshellarg($url);

    // Execute command and capture output
    $output = shell_exec($cmd);

    if (!$output) {
        return [
            'success' => false,
            'error' => 'Failed to extract URLs'
        ];
    }

    // yt-dlp returns video and audio URLs line by line
    $lines = array_filter(array_map('trim', explode("\n", $output)));

    return [
        'success' => true,
        'video_url' => $lines[0] ?? null,
        'audio_url' => $lines[1] ?? null
    ];
}

// Example usage
$url = "https://www.youtube.com/watch?v=h3r4aUYo6cA";
$result = getYoutubeLinks($url);

if ($result['success']) {
    echo "Video URL: " . $result['video_url'] . PHP_EOL;
    echo "Audio URL: " . $result['audio_url'] . PHP_EOL;
} else {
    echo "Error: " . $result['error'] . PHP_EOL;
}
