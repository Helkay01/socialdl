<?php

$url = $_POST['url'] ?? null;
if (!$url) {
    http_response_code(400);
    exit("URL required");
}

// Replace with your Python service URL on Render
$python_service_url = "https://socialdl-python.onrender.com:10000/yt";

$payload = json_encode(["url" => $url]);

$ch = curl_init($python_service_url);
curl_setopt_array($ch, [
    CURLOPT_POST => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => ["Content-Type: application/json"],
    CURLOPT_POSTFIELDS => $payload,
    CURLOPT_TIMEOUT => 30
]);

$response = curl_exec($ch);

if ($response === false) {
    http_response_code(502);
    exit("Python service unreachable");
}

curl_close($ch);

header("Content-Type: application/json");
echo $response;
