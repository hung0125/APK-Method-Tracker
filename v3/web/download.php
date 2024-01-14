<?php
    function compareStrings($str1, $str2) {
        // Extract the first numbers from the strings
        $t1 = intval(explode('-', $str1)[0]);
        $t2 = intval(explode('-', $str2)[0]);
        // Sort in descending order
        if ($t1 === $t2) {
            return 0;
        }
        return ($t1 > $t2) ? -1 : 1;
    }
    
    function mergeFiles($files) {
        $finalFile = "merged/" . explode("-", end($files))[0] . '.txt';
        // Delete existing
        unlink($finalFile);

        // Create an empty string to store merged contents
        $mergedContents = '';
    
        // Read the contents of each file and append it to the merged contents
        foreach ($files as $f) {
            $fileContents = file_get_contents('dump/' . $f);
            $mergedContents .= $fileContents;
        }

        file_put_contents($finalFile, $mergedContents, LOCK_EX);
        
        if (file_exists($finalFile))
            echo 'SUCCESS';
    }

    $directory = 'dump/'; // Replace with the actual directory path
    // Get all the filenames in the directory
    $filenames = scandir($directory);

    // Sort the list of strings
    usort($filenames, 'compareStrings');

    // Loop through each filename
    $shown = array();
    foreach ($filenames as $filename) {
        // Check if the filename matches the specified format
        if (preg_match('/^(\d+)-(\d+)_of_(\d+).txt$/', $filename, $matches)) {
            if (empty($shown[$matches[1]])) {
                $shown[$matches[1]] = true;            
                // Generate a clickable link with a JavaScript onclick event
                echo '<a href="#" onclick="callPhpFunction(\'' . $filename . '\')">' . $filename . '</a><br>';
            }
        }
    }

    $filename = $_GET['filename'] ?? '';
    $dls = array();

    if (!empty($filename)) {
        $t = explode("-", $filename)[0];
        foreach ($filenames as $fname) {
            if (preg_match('/^(\d+)-(\d+)_of_(\d+).txt$/', $fname, $matches)) {
                if ($matches[1] === $t) {
                    $dls[intval($matches[2])] = $fname;
                }
            }
        }
        ksort($dls);
        mergeFiles($dls);
    }
?>

<script>
    function callPhpFunction(filename) {
        alert("Preparing merge and download...");

        // Make an AJAX request to the PHP function
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'download.php?filename=' + filename, true);
        xhr.onload = function() {
            if (xhr.status === 200 && (xhr.response.match(/SUCCESS/g) || []).length == 2) {
                // Handle the response from the PHP function, if needed
                window.open("./merged/" + filename.split("-")[0] + ".txt", "_blank");
            } else {
                alert("Sorry. Could not merge files.");
            }
        };
        xhr.send();
    }
</script>