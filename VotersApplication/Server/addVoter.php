<?php

session_start();


$servername = "localhost";
$username_db = "root";
$password_db = "";
$dbname = "voters_application";

$conn = new mysqli($servername, $username_db, $password_db, $dbname);


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$name = $_POST['voterName'];
$date_of_birth = $_POST['date_of_birth'];
$address = $_POST['address'];
$image = $_FILES['voterImage']['tmp_name'];
$council = $_POST['voterCouncil'];
$polling_station = $_POST['voterPollingStation'];
$user_id = $_SESSION["user_id"];


if (is_uploaded_file($image)) {

    $imageData = file_get_contents($image);


    $escapedImageData = $conn->real_escape_string($imageData);


    $sql = "INSERT INTO voters (name,date_of_birth, address, image, council, polling_station, user_id)
            VALUES ('$name','$date_of_birth', '$address', '$escapedImageData', '$council', '$polling_station', '$user_id')";


    try {

        if ($conn->query($sql) === TRUE) {
            http_response_code(200);
            echo json_encode(['success' => true, 'message' => 'Voter added successfully.']);
        } else {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Error inserting data into the database: ' . $conn->error]);
        }
    } catch (Exception $e) {

        if (strpos($e->getMessage(), "Got a packet bigger than 'max_allowed_packet' bytes") !== false) {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Error: The size of the data you are trying to insert exceeds the maximum allowed packet size. Please contact the administrator to increase the "max_allowed_packet" configuration in MySQL.']);
        } else {
            http_response_code(500);
            echo json_encode(['success' => false, 'message' => 'Unexpected error: ' . $e->getMessage()]);
        }
    }
} else {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Error uploading the image.']);
}


$conn->close();
