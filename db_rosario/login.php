<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

// DB connection
$conn = new mysqli("localhost", "root", "", "db_rosario");

if ($conn->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Database connection failed"
    ]);
    exit();
}

// Get input data
$data = json_decode(file_get_contents("php://input"));

// Validate input
if (!isset($data->email) || !isset($data->password)) {
    echo json_encode([
        "success" => false,
        "message" => "Missing required fields"
    ]);
    exit();
}

$email = $conn->real_escape_string($data->email);
$password = $data->password;

// Look up user by email
$query = "SELECT * FROM users WHERE email='$email'";
$result = $conn->query($query);

if ($result && $result->num_rows > 0) {
    $user = $result->fetch_assoc();

    // Verify hashed password
    if (password_verify($password, $user['password'])) {
        echo json_encode([
            "success" => true,
            "message" => "Login successful",
            "username" => $user["full_name"]
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Incorrect password"
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "User not found"
    ]);
}
?>
