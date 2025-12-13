<?php

if(isset($_POST['btn'])) {
    
$url = $_POST['url'] ?? null;
if (!$url) {
    http_response_code(400);
    exit("URL required");
}

$payload = json_encode(["url" => $url]);

$ch = curl_init("https://socialdl-u0bq.onrender.com/yt");

curl_setopt_array($ch, [
    CURLOPT_POST => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => ["Content-Type: application/json"],
    CURLOPT_POSTFIELDS => $payload,
    CURLOPT_TIMEOUT => 20
]);

$response = curl_exec($ch);

if ($response === false) {
    http_response_code(502);
    exit("Python service unreachable");
}

curl_close($ch);

// header("Content-Type: application/json");
echo $response;

}

?>

<!DOCTYPE html>
<html>
<head>
    
</head>  

<body>
    
<form method="POST">
    <input type="text" name="url" placeholder="Enter video URL" />
    <button name="btn" type="submit">Get Video Info</button>
</form>

</body>
</html>
