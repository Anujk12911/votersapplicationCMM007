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

$id = $_POST['id'];
$name = $_POST['name'];
$date_of_birth = $_POST['date_of_birth'];
$address = $_POST['address'];
$council = $_POST['council'];
$polling_station = $_POST['polling_station'];


$sql = "UPDATE voters SET name='$name', date_of_birth='$date_of_birth', address='$address', council='$council', polling_station='$polling_station' $updateImage WHERE id='$id'";

if ($conn->query($sql) === TRUE) {
    echo json_encode(array("message" => "Voter updated successfully"));
} else {
    http_response_code(500);
    echo json_encode(array("message" => "Error updating voter: " . $conn->error));
}

$conn->close();