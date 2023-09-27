<?php 

    include('connectDB.php');
 

	
	$fullname = $_POST['fullname'];
	$username = $_POST['username'];
	$password = $_POST['password'];
	

	$con->query("UPDATE users SET fullname = '".$fullname."',password = '".$password."' WHERE username = '".$username."'");

	// $con->query("UPDATE users SET fullname = '{$fullname}',password = '{$password}' WHERE username = '{$username}'");

	// update users 
	// set fullname="pattaraporn",
	// password = "456"
	// where username = "patty"


?>