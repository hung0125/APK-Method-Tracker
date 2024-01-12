<?php
        date_default_timezone_set('Asia/Singapore'); // Set the desired timezone (UTC+8)

        $step = $_GET['step'] ?? '';
        $lines = $_GET['lines'] ?? '';

        if ($step == 1) {
            $logMessage = "[" . date('Y-m-d H:i:s') . "]: The client started recording...\n";
        } elseif ($step == 2) {
            $logMessage = "[" . date('Y-m-d H:i:s') . "]: The client stopped recording -> uploading {$lines} lines of calls...\n";
        }

        // Append the log message to the file
		if (!empty($logMessage)) {
        	file_put_contents('log.txt', $logMessage, FILE_APPEND | LOCK_EX);
        	echo 'Log message appended successfully!';
		}

        // Read log file and convert it into an array of log messages
        $logFile = file_get_contents('log.txt');
        $logMessages = explode("\n", trim($logFile));
        $logMessages = array_reverse($logMessages); // Reverse the order of log messages

        // Create the table header
        $tableHeader = "<tr><th>Timestamp</th><th>Log Message</th></tr>";

        // Create the table rows with log messages
        $tableRows = '';
        foreach ($logMessages as $log) {
            list($timestamp, $message) = explode(']:', $log, 2);
            $tableRows .= "<tr><td style='border: 1px solid black;'>{$timestamp}]</td><td style='border: 1px solid black;'>{$message}</td></tr>";
        }

        // Create the HTML table
        $table = "<table style='border: 1px solid black;'>{$tableHeader}{$tableRows}</table>";

        echo $table;
?>
