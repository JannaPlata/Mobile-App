<?php
header("Content-Type: application/json");
include("db_connection.php");

$data = json_decode(file_get_contents("php://input"), true);

// Debug: save request for inspection
file_put_contents("booking_debug.json", json_encode($data, JSON_PRETTY_PRINT));

// Extract booking fields
$bookingType = $data['booking_type'] ?? '';
$roomId = $data['room_id'] ?? 0;
$roomCount = $data['room_count'] ?? 1;
$userId = $data['user_id'] ?? 0;
$date = $data['date'] ?? date('Y-m-d');
$time = $data['time'] ?? date('H:i:s');
$checkinDate = $data['checkin_date'] ?? '';
$checkoutDate = $data['checkout_date'] ?? '';
$adults = $data['adults'] ?? 0;
$children = $data['children'] ?? 0;
$status = $data['status'] ?? 'pending';

// Validate required fields
if (
    empty($bookingType) || empty($roomId) ||
    empty($userId) || empty($checkinDate) || empty($checkoutDate)
) {
    echo json_encode([
        "success" => false,
        "message" => "Missing required fields",
        "received_data" => $data
    ]);
    exit;
}

// 1. Get user info
$userStmt = $conn->prepare("SELECT full_name, phone, email FROM users WHERE user_id = ?");
$userStmt->bind_param("i", $userId);
$userStmt->execute();
$userStmt->bind_result($fullName, $phone, $email);
if (!$userStmt->fetch()) {
    echo json_encode(["success" => false, "message" => "User not found"]);
    $userStmt->close();
    $conn->close();
    exit;
}
$userStmt->close();

// 2. Check or create customer
$customerStmt = $conn->prepare("SELECT Customer_ID FROM customers WHERE user_id = ?");
$customerStmt->bind_param("i", $userId);
$customerStmt->execute();
$customerStmt->bind_result($customerId);
if ($customerStmt->fetch()) {
    $customerStmt->close();
} else {
    $customerStmt->close();
    $insertCustomerStmt = $conn->prepare("INSERT INTO customers (Name, Contact_number, Email, user_id) VALUES (?, ?, ?, ?)");
    $insertCustomerStmt->bind_param("sssi", $fullName, $phone, $email, $userId);
    if ($insertCustomerStmt->execute()) {
        $customerId = $insertCustomerStmt->insert_id;
    } else {
        echo json_encode(["success" => false, "message" => "Failed to create customer"]);
        $insertCustomerStmt->close();
        $conn->close();
        exit;
    }
    $insertCustomerStmt->close();
}

// 3. Insert booking
$sql = "INSERT INTO bookings 
    (Booking_Type, Room_ID, Room_Count, Customer_ID, User_ID, Date, Time, CheckIn_Date, CheckOut_Date, Adults, Children, Status)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param(
    "siiisssssiss",
    $bookingType,
    $roomId,
    $roomCount,
    $customerId,
    $userId,
    $date,
    $time,
    $checkinDate,
    $checkoutDate,
    $adults,
    $children,
    $status
);

if ($stmt->execute()) {
    $bookingId = $stmt->insert_id;

    // Create custom booking ID: RRH + YYYYMMDD + 5-digit booking number
    $bookingDate = date('Ymd');
    $customBookingId = 'RRH-' . $bookingDate . '-' . str_pad($bookingId, 5, '0', STR_PAD_LEFT);

    // Respond to Flutter immediately
    echo json_encode([
        "success" => true,
        "message" => "Booking successful"
    ]);
    // Flush output buffer so client gets the response
    if (function_exists('fastcgi_finish_request')) {
        fastcgi_finish_request();
    } else {
        @ob_end_flush();
        flush();
    }

    // Now send the email (this happens after the client gets the response)
    $emailData = [
        'full_name' => $fullName,
        'email' => $email,
        'booking_id' => $customBookingId, // use the custom formatted ID
        'checkin_date' => $checkinDate,
        'checkout_date' => $checkoutDate,
        'room_count' => $roomCount,
        'adults' => $adults,
        'children' => $children
    ];

    $ch = curl_init('http://localhost/db_rosario/send_booking_email.php');
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($emailData));
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $emailResponse = curl_exec($ch);
    curl_close($ch);

} else {
    echo json_encode(["success" => false, "message" => "Database error: " . $stmt->error]);
}

$stmt->close();
$conn->close();
