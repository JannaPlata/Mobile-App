<?php
$conn = new mysqli("localhost", "root", "", "db_rosario");

$token = $_GET['token'] ?? '';
$new_password = $_POST['password'] ?? '';

if (!$token) {
    echo "Invalid reset link.";
    exit;
}

// Use prepared statement to prevent SQL injection
$stmt = $conn->prepare("SELECT * FROM users WHERE reset_token = ?");
$stmt->bind_param("s", $token);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    echo "Invalid token.";
    exit;
}

$row = $result->fetch_assoc();

// Check expiration
if (strtotime($row['reset_expires']) < time()) {
    echo "Reset link expired.";
    exit;
}

// If form is submitted
if (!empty($new_password)) {
    $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

    $update = $conn->prepare("UPDATE users SET password=?, reset_token=NULL, reset_expires=NULL WHERE reset_token=?");
    $update->bind_param("ss", $hashed_password, $token);
    $update->execute();

    echo "<p>Password has been reset successfully. You may now <a href='login.html'>login</a>.</p>";
} else {
    // Show styled HTML form
    echo "
    <html>
    <head>
        <title>Reset Password</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f5f5;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
            form {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            input[type='password'] {
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            button {
                background: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <form method='POST'>
            <h2>Reset Your Password</h2>
            <input type='password' name='password' placeholder='New Password' required />
            <button type='submit'>Reset Password</button>
        </form>
    </body>
    </html>
    ";
}
?>
