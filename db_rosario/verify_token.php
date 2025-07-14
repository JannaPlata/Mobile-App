<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = new mysqli("localhost", "root", "", "db_rosario");

$token = $_POST['token'] ?? '';

if (!$token) {
    echo json_encode(["status" => "error", "message" => "Token is required"]);
    exit;
}

$stmt = $conn->prepare("SELECT reset_expires FROM users WHERE reset_token = ?");
$stmt->bind_param("s", $token);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(["status" => "invalid", "message" => "Invalid token"]);
    exit;
}

$row = $result->fetch_assoc();
if (strtotime($row['reset_expires']) < time()) {
    echo json_encode(["status" => "expired", "message" => "Token expired"]);
    exit;
}

echo json_encode(["status" => "valid"]);
?>
