<?php
if (!empty($_POST['new_password']) && !empty($_POST['email']) && !empty($_POST['code'])) {
	$code   = Wo_Secure($_POST['code']);
	$email   = Wo_Secure($_POST['email']);
	$update = true;

	//$is_owner = $db->where('email',$email)->where('email_code',$code)->where('time_code_sent',time(),'>')->getValue(T_USERS,'COUNT(*)');
	
	// if ($is_owner > 0) {
	// 	$update = true;
	// }
	// else{
	// 	$is_owner = $db->where('email',$email)->where('password',$code)->where('time_code_sent',time(),'>')->getValue(T_USERS,'COUNT(*)');
	// 	if ($is_owner > 0) {
	// 		$update = true;
	// 	}
	// 	else{
	// 		$error_code    = 9;
	// 	    $error_message = 'email , code wrong';
	// 	}
	// }
	if (Wo_isValidPasswordResetToken($_POST['code']) === false && Wo_isValidPasswordResetToken2($_POST['code']) === false) {
		$update = false;
	}
	if ($update == true) {
		if (strlen($_POST['new_password']) >= 6) {
			$password = password_hash($_POST['new_password'], PASSWORD_DEFAULT);
			$db->where('email',$email)->update(T_USERS,array('password' => $password,
		                                                     'email_code' => ''));
			$response_data['api_status'] = 200;
			$response_data['message'] = 'Your password was updated';
		}
		else{
			$error_code    = 10;
		    $error_message = 'short password';
		}
	}
}
else{
	$error_code    = 8;
    $error_message = 'new_password , email , code can not be empty';
}