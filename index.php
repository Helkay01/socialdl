<!DOCTYPE html>
<html>
<head>
    <title>YouTube Info</title>
</head>
<body>
    <form method="POST">
        <input type="text" name="url" placeholder="Enter YouTube URL" required>
        <input type="submit" value="Get Video Info">
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $url = escapeshellarg($_POST['url']); // Escape to prevent injection
        $output = shell_exec("python3 script.py $url");
        echo "<pre>$output</pre>";
    }
    ?>
</body>
</html>
