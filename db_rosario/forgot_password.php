<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'auth_email/PHPMailer.php';
require 'auth_email/SMTP.php';
require 'auth_email/Exception.php';

$mail = new PHPMailer(true);
echo "PHPMailer loaded successfully!";

$conn = new mysqli("localhost", "root", "", "db_rosario");

// Get and validate email
$email = $_POST['email'] ?? '';

if (empty($email)) {
    echo "Email is required.";
    exit;
}

// Check if email exists in the database
$stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo "No account found with this email.";
    exit;
}

$user = $result->fetch_assoc();

// Generate token and expiration
$token = bin2hex(random_bytes(16));
$expires = date("Y-m-d H:i:s", time() + 3600); // valid for 1 hour

// Update user record with token
$update = $conn->prepare("UPDATE users SET reset_token = ?, reset_expires = ? WHERE email = ?");
$update->bind_param("sss", $token, $expires, $email);
$update->execute();

// Create reset link
$resetLink = "http://localhost/db_rosario/reset_password.html?token=$token";

// Send email using PHPMailer
$mail = new PHPMailer(true);
try {
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'noreplyrosarioresorts@gmail.com';      
    $mail->Password = 'coyj spjm pdig fxhg';          
    $mail->SMTPSecure = 'tls';
    $mail->Port = 587;

    $mail->setFrom('noreplyrosarioresorts@gmail.com', 'Rosario Resort');
    $mail->addAddress($email);
    $mail->isHTML(true);
    $mail->Subject = 'Reset Your Password';
    $mail->Body = "
        <h3>Reset Password Request</h3>
        <p>Click the link below to reset your password:</p>
        <a href='$resetLink'>$resetLink</a>
        <p>This link will expire in 1 hour.</p>
    ";

    $mail->send();
    echo "Reset link sent to your email.";
} catch (Exception $e) {
    echo "Email could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
?>
