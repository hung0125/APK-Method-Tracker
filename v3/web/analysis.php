<?php
		// Set the file path
        $filePath = 'output.txt';

        // Read the file contents
        $fileContents = file_get_contents($filePath);

        // Convert the encoding to UTF-8 if necessary
        /*if (mb_detect_encoding($fileContents) != 'UTF-8') {
            $fileContents = mb_convert_encoding($fileContents, 'UTF-8');
        }*/
		
		$fileContents = nl2br($fileContents);
        // Display the file contents
        echo $fileContents;
?>