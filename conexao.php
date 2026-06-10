<?php 
$host = "localhost";
$user = "root";
$db = "almoxarifado";
$passwoard = "";
$port = 3307;

$conn = new mysqli($host, $user, $passwoard, $db, $port);

if($conn -> connect_error){
    die("falhar na conexao: ". $conn -> connect.error);
}
?>