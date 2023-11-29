<?php 
include('../database_integration.php');
session_start();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Transaction</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCyIlwnfYj4xDCraUQHRgijb50NPoMGUQvE5g50ogktaz5P1P7QvFCwfK55lHY4" crossorigin="anonymous">

    <style>
        body {
            font-family: sans-serif;
            background-color: #f7f7f7;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background-color: blue;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .transaction-details {
            padding: 20px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }

        .confirmation-message {
            color: blue;
            font-weight: bold;
            text-align: center;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="header">
            <h1>Transaction Confirmation</h1>
        </div>

        <?php
// Check if the user ID is provided in the URL
if (isset($_GET['id'])) {
    // Fetch details based on the provided transfer ID
    $transferId = $_GET['id'];

    // Perform the database query to get transfer details
    $query = "SELECT * FROM transfers WHERE transfer_id = $transferId";
    $result = mysqli_query($conn, $query);

    // Check if the query was successful and if there is at least one row
    if ($result && mysqli_num_rows($result) > 0) {
        // Fetch the data from the result set
        $row = mysqli_fetch_assoc($result);

        // Extract data from the row
        $transactionAmount = $row['amount'];
        $senderWalletId = $row['sender_wallet_id'];
        $receiverWalletId = $row['receiver_wallet_id'];
        $transactionStatus = $row['status'];

        // Query to get sender's email using sender wallet ID
        $senderQuery = "SELECT users.email 
                FROM transfers
                JOIN wallets ON transfers.sender_wallet_id = wallets.wallet_id
                JOIN users ON wallets.user_id = users.user_id
                WHERE transfers.sender_wallet_id = $senderWalletId";

        $senderResult = mysqli_query($conn, $senderQuery);
        $senderRow = mysqli_fetch_assoc($senderResult);
        $senderEmail = $senderRow['email'];

        // Query to get receiver's email using receiver wallet ID
        $receiverQuery = "SELECT users.email 
                FROM transfers
                JOIN wallets ON transfers.receiver_wallet_id  = wallets.wallet_id
                JOIN users ON wallets.user_id = users.user_id
                WHERE transfers.receiver_wallet_id = $receiverWalletId";
        $receiverResult = mysqli_query($conn, $receiverQuery);
        $receiverRow = mysqli_fetch_assoc($receiverResult);
        $receiverEmail = $receiverRow['email'];

        // Display the transaction details
        echo '<div class="transaction-details">
                <p>Amount: <span id="transactionAmount">' . $transactionAmount . '</span></p>
                <p>Sender Email: <span id="transactionSenderEmail">' . $senderEmail . '</span></p>
                <p>Receiver Email: <span id="transactionReceiverEmail">' . $receiverEmail . '</span></p>
                <p>Status: <span id="transactionStatus">' . $transactionStatus . '</span></p>
            </div>';

        // Display the confirmation message
        echo '<div class="confirmation-message">
                <p>Your transaction has been successfully processed.</p>
            </div>';
    } else {
        // If no data is found or an error occurred, display an error message
        echo '<div class="confirmation-message">
                <p>Error: Transfer data not found or database query failed.</p>
            </div>';
    }
} else {
    // If transfer ID is not provided, display an error message or redirect to an error page
    echo '<div class="confirmation-message">
            <p>Error: Transfer ID not provided.</p>
        </div>';
}
?>



        <div class="button-container">
            <a href="./TransectionRecords.php" class="btn btn-primary">Return to Home</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js" integrity="sha384-vt50PYvX5X1tTQuGcPoK5u5g/KD2Z/HqHIKlTsk9xymTWoJ9g+4v6OnVl8Yx0i" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-Q6fnB/OpE6lMpoE5Dq7umDbrGE4AKLN7TUHqRg5qcG0sKT5gmzP+s4cZ7KtqY1+7" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPkDaC7TmJ3+Yp6d0q3gEJZ7/WF78rf9v/8fY4ka9K9qO2Z75ebglt4j9PCau" crossorigin="anonymous"></script>

</body>

</html>
