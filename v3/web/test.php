<?php
try {
  $logMessage = "[" . date('Y-m-d H:i:s') . "]: The server is processing recording...\n";
  file_put_contents("log.txt", $logMessage,  FILE_APPEND | LOCK_EX);
	$data = file_get_contents("php://input"); 
	file_put_contents("output.txt", $data);
  $logMessage = "[" . date('Y-m-d H:i:s') . "]: The server saved the recording...\n";
  file_put_contents("log.txt", $logMessage,  FILE_APPEND | LOCK_EX);
} catch (Exception $e) {
    file_put_contents("error.txt", "error when processing upload: " . $e->getMessage() . "\n",  FILE_APPEND | LOCK_EX);
    echo 'Caught exception: ',  $e->getMessage(), "\n";
}
?>
