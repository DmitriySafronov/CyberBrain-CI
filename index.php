<?php

# DEFAULTS
$launcher = "/usr/local/sbin/Launcher.sh";
$recipes_dir = "/var/local/CyberBrain-CI";

# Override DEFAULTS (if any)
include(config.php);

##########################################################

$service_name = '';
$error = false;
$json = file_get_contents('php://input');
$payload = json_decode($json);

##########################################################

$repository = $payload -> repository;
$repository_full_name = $repository -> full_name;

##########################################################

if (substr_count($repository -> url, 'github.com') > 0) $service_name = 'github.com';
if (substr_count($repository -> links -> self -> href, 'bitbucket.org') > 0) $service_name = 'bitbucket.org';

##########################################################

if ($service_name == '') {
    $error = true;
}

$local_name = $service_name."/".$repository_full_name;
$filename = addslashes($recipes_dir)."/".addslashes($local_name).".sh";

if (!file_exists($filename)) {
    $error = true;
}

if (!file_exists($launcher)) {
    $error = true;
}

##########################################################

if ($error == true) {
    header("HTTP/1.0 404 Not Found");
} else {
    echo "Executing scripts for [".$local_name."]...";
    exec("setsid $launcher $filename");
}

?>
