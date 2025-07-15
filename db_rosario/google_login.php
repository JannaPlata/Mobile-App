<?php
header("Content-Type: application/json");

$data = json_decode(file_get_contents("php://input"), true);
$email = $data['email'] ?? '';
$name = $data['name'] ?? '';
$photo = $data['photo'] ?? ''; // Optional

$conn = new mysqli("localhost", "root", "", "db_rosario");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit();
}

// Check if user exists
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
    // Auto-register the user
    $insert = $conn->prepare("INSERT INTO users (full_name, email, password) VALUES (?, ?, '')");
    $insert->bind_param("ss", $name, $email);

    if ($insert->execute()) {
        echo json_encode([
            "success" => true,
            "username" => $name
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Failed to auto-register Google account"
        ]);
    }
}

$conn->close();
?>
