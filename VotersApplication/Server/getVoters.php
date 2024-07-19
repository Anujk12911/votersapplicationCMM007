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


$sql = "SELECT * FROM voters";
$result = $conn->query($sql);

$voters = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {

        $imageData = base64_encode($row['image']);


        $voters[] = array(
            'id' => $row['id'],
            'name' => $row['name'],
            'date_of_birth' => $row['date_of_birth'],
            'image' => $imageData,
            'address' => $row['address'],
            'council' => $row['council'],
            'polling_station' => $row['polling_station'],
            'created_at' => $row['created_at'],
            'updated_at' => $row['updated_at']
        );
    }
}


$conn->close();


header('Content-Type: application/json');
echo json_encode($voters);
