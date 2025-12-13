<?php

$url = 'https://www.youtube.com/watch?v=oDAw7vW7H0c';
$yt = '/usr/local/bin/yt-dlp';

$cmd = escapeshellcmd("$yt --cookies-from-browser chrome -g $url");
$videoLink = trim(shell_exec($cmd));

echo $videoLink ?: 'Failed to fetch video URL';
