<?php

header("Content-Type: application/json");

if (!isset($_GET['url'])) {
    http_response_code(400);
    echo json_encode(["error" => "Missing url"]);
    exit;
}

$url = escapeshellarg($_GET['url']);

$cmd = "python3 " . __DIR__ . "/extract.py $url";
$output = shell_exec($cmd);

if (!$output) {
    http_response_code(500);
    echo json_encode(["error" => "Extraction failed"]);
    exit;
}

echo $output;
