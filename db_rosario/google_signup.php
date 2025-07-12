<?php
header("Content-Type: application/json");

$data = json_decode(file_get_contents("php://input"), true);

$email = $data['email'] ?? '';
$name = $data['name'] ?? '';
$photo = $data['photo'] ?? '';

$conn = new mysqli("localhost", "root", "", "db_rosario");

if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit();
}

// 🔎 Check if the Google account is already registered
$stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode([
        "success" => false,
        "message" => "This Google account is already registered."
    ]);
} else {
    // ✅ Register new Google user
    $stmt = $conn->prepare("INSERT INTO users (full_name, email, password, photo) VALUES (?, ?, '', ?)");
    $stmt->bind_param("sss", $name, $email, $photo);
    if ($stmt->execute()) {
        echo json_encode([
            "success" => true,
            "username" => $name,
            "photo" => $photo,
            "message" => "Signed up successfully as $name"
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Failed to register Google account"
        ]);
    }
}

$conn->close();
?>
