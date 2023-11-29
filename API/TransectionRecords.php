<?php 
include('../database_integration.php');
session_start();
$userData =  $_SESSION['user'];
// echo $userData['user_id'] .' '. $userData['username'];
if(!isset($userData['user_id']) && !isset($userData['username']) && !isset($userData['email']))
{
    header("Location: ./index.html");
    exit();
}

// Transfer Checking



// {Functions}
// Get the balance
$balance = 0.0;
$currency = 'pak';
                        // Assuming $userData['user_id'] holds the user's ID
                        $userId = $userData['user_id'];

                        // Fetch balance from the wallets table for the given user ID
                        $balanceQuery = "SELECT * FROM wallets WHERE user_id = '$userId'";
                        $balanceResult = mysqli_query($conn, $balanceQuery);

                        // Check if the query was successful
                        if ($balanceResult) {
                            $row = mysqli_fetch_assoc($balanceResult);
                        
                            // Check if the user has a balance record
                            if ($row) {
                                $balance = $row['balance'] ?? 0.0;
                                $currency = $row['currency'] ?? '';
                                
                            } else {
                                // echo "<h1>No balance record found for the user</h1>";
                            }
                        } else {
                            // echo "<h1>Error fetching balance</h1>";
                        }
 ?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Genius Admin- Merchant Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
        integrity="sha512-JmrRs0rW2uFGej6H5O8r13m//He27UpWoj9LmM5Zj0K0jIuI2PnEJKkBlUfsVmXEWdwPHocUIksa1RV5MS9jEA=="
        crossorigin="anonymous" />
    <link rel="shortcut icon" href="./assets/images/5480339181644482400.png">
    <link rel="stylesheet" href="../assets/merchant/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/merchant/css/font-awsome.min.css">
    <link rel="stylesheet" href="../assets/merchant/css/selectric.css">
    <link rel="stylesheet" href="../assets/merchant/css/jquery-ui.min.css">
    <link rel="stylesheet" href="../assets/merchant/css/select2.min.css">
    <link rel="stylesheet" href="../assets/merchant/css/tagify.css">
    <link rel="stylesheet" href="../assets/merchant/css/summernote.css">
    <link rel="stylesheet" href="../assets/merchant/css/bootstrap-iconpicker.min.css">
    <link rel="stylesheet" href="../assets/merchant/css/colorpicker.css">
    <link rel="stylesheet" href="../assets/merchant/css/style.css">
    <link rel="stylesheet" href="../assets/merchant/css/components.css">
    <link rel="stylesheet" href="../assets/merchant/css/custom.css">
    <!-- Add these lines in your HTML head section -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


</head>


<body>

<form action="">
<table class="table card-table table-vcenter text-nowrap datatable">
    <thead>
        <tr>
            <th>Date</th>
            <th>Transaction ID</th>
            <th>Transaction</th>
            <th>Remark</th>
            <th>Amount</th>
            <th>Details</th>
        </tr>
    </thead>
    <tbody>
        <?php
        // Fetch transfers data from the database
        $transferQuery = "SELECT * FROM transfers";
        $result = mysqli_query($conn, $transferQuery);

        // Fetch sender's wallet information
        $getSenderWalletId = "SELECT * FROM wallets WHERE user_id = {$userData['user_id']}";
        $senderWallet = mysqli_query($conn, $getSenderWalletId);

        // Check if sender's wallet exists
        if (mysqli_num_rows($senderWallet) > 0) {
            $senderRow = mysqli_fetch_assoc($senderWallet);
        }

        // Process and display transfer data
        if ($result) {
            while ($row = mysqli_fetch_assoc($result)) {
                // Determine if the logged-in user is the sender or receiver
                $isSender = $row['sender_wallet_id'] == $senderRow['wallet_id'];

                // Set the Transaction column based on sender or receiver
                $transactionColumn = $isSender ? "Sent to: " . $row['receiver_wallet_id'] : "Received from: " . $row['sender_wallet_id'];

                // Set the Amount column color based on sender or receiver
                $amountColor = $isSender ? "text-danger" : "text-success";

                // Display table row
                echo '<tr>
                    <td data-label="Date">' . $row['created_at'] . '</td>
                    <td data-label="Transaction ID">' . $row['transfer_id'] . '</td>
                    <td data-label="Transaction">' . $transactionColumn . '</td>
                    <td data-label="Remark">
                        <span class="badge badge-dark">' . $row['status'] . '</span>
                    </td>
                    <td data-label="Amount">
                        <span class="' . $amountColor . '">$' . $row['amount'] . '</span>
                    </td>
                    <td data-label="Details" class="text-end">
                        <a href="transaction_detail.php?id=' . $row['transfer_id'] . '" class="btn btn-primary btn-sm">Details</a>
                    </td>
                </tr>';
            }
        }
        ?>
    </tbody>
</table>
</div>
</div>
</div>
</form>




<script src="./assets/admin/js/sweetalert2@9.js"></script>






<script>
function toast(type, msg) {
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        onOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    })
    Toast.fire({
        icon: type,
        title: msg
    })
}

function amount(amount, type) {
    if (type == 2) {
        return amount.toFixed(8);
    } else {
        return amount.toFixed();
    }
}
</script>
<script src="./assets/merchant/js/jquery.min.js"></script>
<script src="./assets/merchant/js/popper.min.js"></script>
<script src="./assets/merchant/js/bootstrap.min.js"></script>
<script src="./assets/merchant/js/jquery-ui.min.js"></script>
<script src="./assets/merchant/js/nicescroll.min.js"></script>
<script src="./assets/merchant/js/summernote.js"></script>
<script src="./assets/merchant/js/select2.min.js"></script>
<script src="./assets/merchant/js/tagify.js"></script>
<script src="./assets/merchant/js/sortable.js"></script>
<script src="./assets/merchant/js/moment-a.js"></script>
<script src="./assets/merchant/js/stisla.js"></script>
<script src="./assets/merchant/js/bootstrap-iconpicker.bundle.min.js"></script>
<script src="./assets/merchant/js/colorpicker.js"></script>
<script src="./assets/merchant/js/jquery.uploadpreview.min.js"></script>
<script src="./assets/merchant/js/chart.min.js"></script>
<script src="./assets/merchant/js/scripts.js"></script>
<script src="./assets/merchant/js/custom.js"></script>


<script>
var form_error = "Please fill all the required fields";
var mainurl = ".";
var lang = {
    'new': 'ADD NEW',
    'edit': 'EDIT',
    'details': 'DETAILS',
    'update': 'Status Updated Successfully.',
    'sss': 'Success !',
    'active': 'Activated',
    'deactive': 'Deactivated',
    'loading': 'Please wait Data Processing...',
    'submit': 'Submit',
    'enter_name': 'Enter Name',
    'enter_price': 'Enter Price',
    'per_day': 'Per Day',
    'per_month': 'Per Month',
    'per_year': 'Per Year',
    'one_time': 'One Time',
    'enter_title': 'Enter Title',
    'enter_content': 'Enter Content',
    'extra_price_name': 'Enter Name',
    'extra_price': 'Enter Price',
    'policy_title': 'Enter Title',
    'policy_content': 'Enter Content',
};
</script>


<script>
$(function() {
    'use strict'
    $('.reason').on('click', function() {
        $('#modal-reason').find('.reason-text').val($(this).data('reason'))
        $('#modal-reason').modal('show')
    })

})

$('.summernote').summernote()
</script>
<script>
'use strict';

$('.details').on('click', function() {
    var url = "./merchant/transaction/details" + '/' + $(this).data('data').id
    $('.trx_details').text($(this).data('data').details)
    $.get(url, function(res) {
        if (res == 'empty') {
            $('.list-group').html('<p>No details found!</p>')
        } else {
            $('.list-group').html(res)
        }
        $('#modal-success').modal('show')
    })
})

$('.reason').on('click', function() {
    $('#modal-team').find('.reject-reason').val($(this).data('reason'))
    $('#modal-team').modal('show')
})
</script>
</head>