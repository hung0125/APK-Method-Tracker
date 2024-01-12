<?php
try {
	$data = file_get_contents("php://input"); 
	file_put_contents("output.txt", $data);
} catch (Exception $e) {
    file_put_contents("error.txt", $data,  FILE_APPEND | LOCK_EX);
    echo 'Caught exception: ',  $e->getMessage(), "\n";
}
?>
