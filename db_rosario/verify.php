<?php
$conn = new mysqli("localhost", "root", "", "db_rosario");
if ($conn->connect_error) die("DB error");

$token = $_GET['token'] ?? '';
if (!$token) die("Invalid token");

$sql = "UPDATE users SET verified=1, verification_token=NULL WHERE verification_token='$token'";
if ($conn->query($sql) && $conn->affected_rows > 0) {
    echo "<h2>Your email has been verified! You can now log in.</h2>";
} else {
    echo "<h2>Invalid or expired verification link.</h2>";
}
?> 