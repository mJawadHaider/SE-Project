<?php

include('../database_integration.php');
session_start();
$userData =  $_SESSION['user'];

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validate and sanitize input data
    $amount = filter_var($_POST["amount"], FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
    $currency = filter_var($_POST["currency"], FILTER_SANITIZE_STRING);

    // Additional validation if needed

    // Check if the user already exists in the wallets table
   

    // Close the statement and connection
    $checkUserStmt->close();
    $conn->close();
}
?>
