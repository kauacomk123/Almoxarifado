<?php
session_start();
include 'conexao.php';

if ($_SESSION['perfil'] != 'ADMINISTRADOR') {
    die("Acesso negado!");
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nome = $_POST['nome'];
    $login = $_POST['login'];
    $senha = password_hash($_POST['senha'], PASSWORD_DEFAULT);
    $perfil = $_POST['perfil'];

    $sql = "INSERT INTO usuarios (nome, login, senha, perfil) VALUES (?,?,?,?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssss", $nome, $login, $senha, $perfil);
    $stmt->execute();
    echo "Usuário cadastrado com sucesso!";
}
?>
<link rel="stylesheet" href="style.css">

<form method="POST">
    <h2>Cadastrar Usuário</h2>
    Nome: <input type="text" name="nome" required><br>
    Login: <input type="text" name="login" required><br>
    Senha: <input type="password" name="senha" required><br>
    Perfil: 
    <select name="perfil">
        <option value="OPERADOR">Operador</option>
        <option value="ADMINISTRADOR">Administrador</option>
    </select><br>
    <button type="submit">Cadastrar</button>
</form>
 <br><br>
<a href="dashboard.php" class="voltar-btn">Voltar</a>
