<?php
// Debug: log when script is called
file_put_contents("hit_email_php.txt", date('c') . " - send_booking_email.php called\n", FILE_APPEND);

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require __DIR__ . '/auth_email/PHPMailer.php';
require __DIR__ . '/auth_email/SMTP.php';
require __DIR__ . '/auth_email/Exception.php';

// Log incoming data
$data = json_decode(file_get_contents("php://input"), true);
file_put_contents("booking_email_data.txt", json_encode($data, JSON_PRETTY_PRINT));

// Extract values
$fullName = $data['full_name'] ?? '';
$email = $data['email'] ?? '';
$bookingId = $data['booking_id'] ?? '';
$checkinDate = $data['checkin_date'] ?? '';
$checkoutDate = $data['checkout_date'] ?? '';

// Log recipient
file_put_contents("booking_email_recipient.txt", $email);

// Validate
if (empty($fullName) || empty($email) || empty($bookingId)) {
    echo json_encode([
        "success" => false,
        "error" => "Missing required fields",
        "received" => $data
    ]);
    exit;
}

$mail = new PHPMailer(true);

try {
    // SMTP config
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'noreplyrosarioresorts@gmail.com';        
    $mail->Password   = 'coyj spjm pdig fxhg';           
    $mail->Port       = 587;

    // Email content
    $mail->setFrom('noreplyrosarioresorts@gmail.com', 'Rosario Resorts');
    $mail->addAddress($email); // Only send to the user

    $mail->isHTML(true);
    $mail->Subject = 'Booking Request Received';
    $mail->Body    = "
        Hi $fullName,<br><br>
        We’ve received your booking request. Please review your booking details below:<br><br>
        📄 <b>Booking Details:</b><br>
        • Booking ID: $bookingId<br>
        • Check-in: $checkinDate<br>
        • Check-out: $checkoutDate<br>
        • Rooms: {$data['room_count']}<br>
        • Adults: {$data['adults']}<br>
        • Children: {$data['children']}<br>
        • Status: Pending<br><br>
        Our team will review your request and get back to you shortly with a confirmation.<br><br>
        🛎️ Thank you for choosing <b>Rosario Resorts and Hotel</b>! We look forward to welcoming you.<br>
        <hr>
        <small>This is an automated message. Please do not reply to this email.</small>
    ";

    $mail->send();
    echo json_encode(["success" => true, "message" => "Email sent"]);
} catch (Throwable $e) {
    file_put_contents('email_error.txt', $mail->ErrorInfo . "\nException: " . $e->getMessage());
    echo json_encode([
        "success" => false,
        "error" => $mail->ErrorInfo,
        "exception" => $e->getMessage()
    ]);
}
