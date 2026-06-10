<?php
session_start();
include 'conexao.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nome = $_POST['nome'];
    $descricao = $_POST['descricao'];
    $quantidade = $_POST['quantidade'];

    $sql = "INSERT INTO materiais (nome, descricao, quantidade_atual) VALUES (?,?,?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssi", $nome, $descricao, $quantidade);
    $stmt->execute();
    echo "Material cadastrado com sucesso!";
}
?>
<link rel="stylesheet" href="style.css">

<form method="POST">
    <h2>Cadastrar Material</h2>
    Nome: <input type="text" name="nome" required><br>
    Descrição: <input type="text" name="descricao"><br>
    Quantidade Inicial: <input type="number" name="quantidade" required><br>
    <button type="submit">Cadastrar</button>

</form>
 <br><br>
<a href="dashboard.php" class="voltar-btn">Voltar</a>

