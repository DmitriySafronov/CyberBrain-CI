<?php
if (!file_exists(worker.sh)) $error = true;

##########################################################
##########################################################

$error = false;
$json = file_get_contents('php://input');
$payload = json_decode($json);

##########################################################

$repository = $payload -> repository;
$repository_full_name = $repository -> full_name;

##########################################################

$service_name = '';
if (substr_count($repository -> url, 'github.com') > 0) $service_name = 'github.com';
if (substr_count($repository -> links -> self -> href, 'bitbucket.org') > 0) $service_name = 'bitbucket.org';
if ($service_name == '') $error = true;

##########################################################

$local_name = addslashes($service_name."/".$repository_full_name);

##########################################################
##########################################################

if ($error == true) {
    header("HTTP/1.0 404 Not Found");
} else {
    echo "Attemting to execute scripts for [".$local_name."]...";
    exec("bash ./worker.sh $local_name >/dev/null 2>/dev/null &");
}
?>
