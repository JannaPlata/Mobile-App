<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require __DIR__ . '/auth_email/PHPMailer.php';
require __DIR__ . '/auth_email/SMTP.php';
require __DIR__ . '/auth_email/Exception.php';

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
$check = $conn->query("SELECT user_id FROM users WHERE email = '$email'");
if ($check && $check->num_rows > 0) {
    echo json_encode(["success" => false, "message" => "Email already exists."]);
    exit();
}

// Generate verification token
$token = bin2hex(random_bytes(32));

// Insert user (set verified=0, store token)
$sql = "INSERT INTO users (full_name, email, phone, password, verified, verification_token) VALUES ('$full_name', '$email', '$phone', '$password', 0, '$token')";
if ($conn->query($sql)) {
    // Send verification email using PHPMailer
    $verify_link = "http://localhost/db_rosario/verify.php?token=$token";
    $mail = new PHPMailer\PHPMailer\PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = 'noreplyrosarioresorts@gmail.com';
        $mail->Password   = 'coyj spjm pdig fxhg';
        $mail->SMTPSecure = 'tls';
        $mail->Port       = 587;

        $mail->setFrom('noreplyrosarioresorts@gmail.com', 'Rosario Resorts');
        $mail->addAddress($email);

        $mail->isHTML(true);
        $mail->Subject = 'Verify your email';
        $mail->Body    = "Click the link to verify your account: <a href='$verify_link'>$verify_link</a>";

        $mail->send();
        echo json_encode(["success" => true, "message" => "Registered successfully! Please check your email to verify your account."]);
    } catch (Exception $e) {
        file_put_contents('email_error.txt', $mail->ErrorInfo);
        echo json_encode(["success" => true, "message" => "Registered, but failed to send verification email."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Registration failed."]);
}
