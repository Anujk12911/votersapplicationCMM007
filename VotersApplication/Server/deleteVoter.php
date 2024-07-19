<?php
// Start or resume a session
session_start();

// Check if the user is logged in and has the admin role
if (!isset($_SESSION["user_id"]) || $_SESSION["role"] !== 'election_officer') {
    echo json_encode(['success' => false, 'message' => 'Unauthorized access']);
    http_response_code(401);  // Unauthorized
    exit();
}

// Connect to MySQL
$servername = "localhost";
$username_db = "root";
$password_db = "";
$dbname = "voters_application";

$conn = new mysqli($servername, $username_db, $password_db, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed: ' . $conn->connect_error]);
    http_response_code(500);  // Internal Server Error
    exit();
}

// Get voter ID from the POST request
$voterId = $_POST['voterId'];

// Delete the voter from the database
$sql = "DELETE FROM voters WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $voterId);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Voter deleted successfully']);
    http_response_code(200);  // OK
} else {
    echo json_encode(['success' => false, 'message' => 'Error deleting voter: ' . $stmt->error]);
    http_response_code(500);  // Internal Server Error
}

// Close the prepared statement
$stmt->close();

// Close the database connection
$conn->close();
