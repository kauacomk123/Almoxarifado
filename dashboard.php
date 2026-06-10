<?php
session_start();
if (!isset($_SESSION['id_usuario'])) {
    header("Location: index.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="dashboard.css">

    <title>Dashboard - Almoxarifado</title>
</head>
<body>
    <h2>Bem-vindo, <?php echo $_SESSION['nome']; ?>!</h2>
    <p>Perfil: <?php echo $_SESSION['perfil']; ?></p>

    <ul>
        <li><a href="cadastro_usuario.php">Cadastro de Usuários</a></li>
        <li><a href="cadastro_material.php">Cadastro de Materiais</a></li>
        <li><a href="movimentacao.php">Registrar Movimentação</a></li>
        <li><a href="relatorio.php">Relatórios</a></li>
        <li><a href="logout.php">Sair</a></li>
    </ul>
</body>
</html>
