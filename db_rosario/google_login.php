<?php
header("Content-Type: application/json");

$data = json_decode(file_get_contents("php://input"), true);
$email = $data['email'] ?? '';

$conn = new mysqli("localhost", "root", "", "db_rosario");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit();
}

// Only allow existing accounts to log in
$stmt = $conn->prepare("SELECT full_name FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    echo json_encode([
        "success" => true,
        "username" => $user['full_name']
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Google account not registered. Please sign up first."
    ]);
}

$conn->close();
?>