<html>
<h2>Downloads <button href="#" onclick="clearData('dump')">Clear Data</button></h2>
<iframe width=80% height=200 style="margin-left: 8%; margin-bottom: 20px;" src='./download.php'></iframe>
<h2>Logs <button href="#" onclick="clearData('logs')">Clear Logs</button></h2>
<?php
    date_default_timezone_set('Asia/Singapore'); // Set the desired timezone (UTC+8)

    $step = $_GET['step'] ?? '';
    $lines = $_GET['lines'] ?? '';
    $action = $_GET['action'] ?? '';
    $clear = $_GET['clear'] ?? '';

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
    if (!empty($logFile)) {
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
    } else {
        echo '<h3>No Record Found.</h3>';
    }

    // Clear all files
    if (!empty($action) && $action == 'clear') {
        if ($clear == 'dump') {
            $folders = [glob('dump/*'), glob('merged/*')];

            // Loop through each file and delete it
            foreach ($folders as $fd) {
                foreach ($fd as $file) {
                    if (is_file($file)) {
                        unlink($file);
                    }
                }
            }
        } elseif ($clear == 'logs') {
            file_put_contents("log.txt", "");
        }
        
    }
?>

<script>
    function clearData(param) {
        alert("Clear " + param + " request sent.");
        // Make an AJAX request to the PHP function
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'logger.php?action=clear&clear='+param, true);
        xhr.onload = function() {};
        xhr.send();
    }

</script>
</html>