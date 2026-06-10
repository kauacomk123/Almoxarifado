<?php
session_start();
include 'conexao.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_material = $_POST['id_material'];
    $tipo = $_POST['tipo'];
    $quantidade = $_POST['quantidade'];
    $id_usuario = $_SESSION['id_usuario'];

    $sql = "INSERT INTO movimentacoes (id_material, tipo, quantidade, id_usuario) VALUES (?,?,?,?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("isii", $id_material, $tipo, $quantidade, $id_usuario);
    $stmt->execute();
    echo "Movimentação registrada!";
}

$result = $conn->query("SELECT * FROM materiais");
?>
<link rel="stylesheet" href="style.css">

<form method="POST">
    <h2>Registrar Movimentação</h2>
    Material: 
    <select name="id_material">
        <?php while($row = $result->fetch_assoc()) { ?>
            <option value="<?php echo $row['id_material']; ?>">
                <?php echo $row['nome']; ?> (Saldo: <?php echo $row['quantidade_atual']; ?>)
            </option>
        <?php } ?>
    </select><br>
    Tipo: 
    <select name="tipo">
        <option value="ENTRADA">Entrada</option>
        <option value="SAIDA">Saída</option>
    </select><br>
    Quantidade: <input type="number" name="quantidade" required><br>
    <button type="submit">Registrar</button>
</form>
 <br><br>
<a href="dashboard.php" class="voltar-btn">Voltar</a>
