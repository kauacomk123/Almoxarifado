<?php
session_start();
include 'conexao.php';

$sql = "SELECT m.id_mov, mat.nome AS material, m.tipo, m.quantidade, m.data_hora, u.nome AS usuario
        FROM movimentacoes m
        JOIN materiais mat ON m.id_material = mat.id_material
        JOIN usuarios u ON m.id_usuario = u.id_usuario
        ORDER BY m.data_hora DESC";
$result = $conn->query($sql);
?>
<link rel="stylesheet" href="style.css">

<h2>Relatório de Movimentações</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Material</th>
        <th>Tipo</th>
        <th>Quantidade</th>
        <th>Data/Hora</th>
        <th>Usuário</th>
    </tr>
    <?php while($row = $result->fetch_assoc()) { ?>
    <tr>
        <td><?php echo $row['id_mov']; ?></td>
        <td><?php echo $row['material']; ?></td>
        <td><?php echo $row['tipo']; ?></td>
        <td><?php echo $row['quantidade']; ?></td>
        <td><?php echo $row['data_hora']; ?></td>
        <td><?php echo $row['usuario']; ?></td>
    </tr>
    <?php } ?>
</table>
 <br><br>
<a href="dashboard.php" class="voltar-btn">Voltar</a>
