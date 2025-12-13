<?php

$url = 'https://www.youtube.com/watch?v=h3r4aUYo6cA';
$yt  = '/usr/local/bin/yt-dlp';

$cmd = sprintf(
    '%s -f best -g %s 2>&1',
    escapeshellcmd($yt),
    escapeshellarg($url)
);

$output = shell_exec($cmd);

echo $output ?: 'Failed to fetch video URL';
