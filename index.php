<?php

$url = 'https://www.youtube.com/watch?v=h3r4aUYo6cA';
$yt = '/usr/local/bin/yt-dlp';

$cmd = escapeshellcmd("$yt -f bestvideo+bestaudio -g $url");
$videoLink = trim(shell_exec($cmd));

echo $videoLink ?: 'Failed to fetch video URL';
