<?php
// Call Python script
$output = shell_exec("python3 script.py");
echo "Python Output: " . $output;
?>
