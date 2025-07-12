<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Connect to database
$conn = new mysqli("localhost", "root", "", "db_rosario");
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit();
}

// Get input data
$data = json_decode(file_get_contents("php://input"));

if (
    empty($data->full_name) ||
    empty($data->email) ||
    empty($data->phone) ||
    empty($data->password)
) {
    echo json_encode(["success" => false, "message" => "Missing required fields."]);
    exit();
}

// Sanitize inputs
$full_name = $conn->real_escape_string(trim($data->full_name));
$email = $conn->real_escape_string(trim($data->email));
$phone = $conn->real_escape_string(trim($data->phone));
$password = password_hash(trim($data->password), PASSWORD_DEFAULT);

// Check if email already exists
$check = $conn->query("SELECT id FROM users WHERE email = '$email'");
if ($check && $check->num_rows > 0) {
    echo json_encode(["success" => false, "message" => "Email already exists."]);
    exit();
}

// Insert user
$sql = "INSERT INTO users (full_name, email, phone, password) VALUES ('$full_name', '$email', '$phone', '$password')";
if ($conn->query($sql)) {
    echo json_encode(["success" => true, "message" => "Registered successfully!"]);
} else {
    echo json_encode(["success" => false, "message" => "Registration failed."]);
}
?>
