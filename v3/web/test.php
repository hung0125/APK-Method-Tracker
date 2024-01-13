<?php

	date_default_timezone_set('Asia/Singapore'); // Set the desired timezone (UTC+8)
	try {
		$logMessage = "[" . date('Y-m-d H:i:s') . "]: Server received recording...\n";
		file_put_contents("log.txt", $logMessage,  FILE_APPEND | LOCK_EX);
		
		$data = file_get_contents("php://input"); 
		$stamp = end(explode("\n", $data));
		file_put_contents("dump/" . $stamp . ".txt", rtrim(substr($data, 0, (strlen($stamp) + 1) * -1)));

		$logMessage = "[" . date('Y-m-d H:i:s') . "]: Server saved recording: " . $stamp . "\n";
		file_put_contents("log.txt", $logMessage,  FILE_APPEND | LOCK_EX);
	} catch (Exception $e) { 
		$logMessage = "[" . date('Y-m-d H:i:s') . "]: Server got error, see error.txt \n";
		file_put_contents("log.txt", $logMessage,  FILE_APPEND | LOCK_EX);

		file_put_contents("error.txt", "error when processing upload: " . $e->getMessage() . "\n",  FILE_APPEND | LOCK_EX);
	}
?>