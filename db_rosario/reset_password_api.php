<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$conn = new mysqli("localhost", "root", "", "db_rosario");

$token = $_POST['token'] ?? '';
$new_password = $_POST['password'] ?? '';

if (!$token || !$new_password) {
    echo json_encode(["status" => "error", "message" => "Token and password are required"]);
    exit;
}

$hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

$stmt = $conn->prepare("UPDATE users SET password=?, reset_token=NULL, reset_expires=NULL WHERE reset_token=?");
$stmt->bind_param("ss", $hashed_password, $token);
$stmt->execute();

if ($stmt->affected_rows > 0) {
    echo json_encode(["status" => "success", "message" => "Password has been reset"]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to reset password"]);
}
?>
