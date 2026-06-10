-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Tempo de geração: 10/06/2026 às 15:05
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `almoxarifado`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `materiais`
--

CREATE TABLE `materiais` (
  `id_material` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `quantidade_atual` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `materiais`
--

INSERT INTO `materiais` (`id_material`, `nome`, `descricao`, `quantidade_atual`) VALUES
(1, 'madeira', 'madeira carvalho', 150),
(2, 'telha', 'telha termite', 91),
(3, 'teste material', 'aaa', 9);

-- --------------------------------------------------------

--
-- Estrutura para tabela `movimentacoes`
--

CREATE TABLE `movimentacoes` (
  `id_mov` int(11) NOT NULL,
  `id_material` int(11) NOT NULL,
  `tipo` enum('ENTRADA','SAIDA') NOT NULL,
  `quantidade` int(11) NOT NULL,
  `data_hora` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `movimentacoes`
--

INSERT INTO `movimentacoes` (`id_mov`, `id_material`, `tipo`, `quantidade`, `data_hora`, `id_usuario`) VALUES
(1, 2, 'SAIDA', 10, '2026-06-10 12:38:15', 1),
(2, 2, 'ENTRADA', 1, '2026-06-10 12:38:34', 1),
(3, 1, 'SAIDA', 50, '2026-06-10 12:40:05', 2),
(4, 3, 'SAIDA', 1, '2026-06-10 12:59:22', 2);

--
-- Acionadores `movimentacoes`
--
DELIMITER $$
CREATE TRIGGER `atualiza_estoque` AFTER INSERT ON `movimentacoes` FOR EACH ROW BEGIN
    IF NEW.tipo = 'ENTRADA' THEN
        UPDATE materiais SET quantidade_atual = quantidade_atual + NEW.quantidade
        WHERE id_material = NEW.id_material;
    ELSEIF NEW.tipo = 'SAIDA' THEN
        UPDATE materiais SET quantidade_atual = quantidade_atual - NEW.quantidade
        WHERE id_material = NEW.id_material;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `login` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `perfil` enum('OPERADOR','ADMINISTRADOR') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nome`, `login`, `senha`, `perfil`) VALUES
(1, 'kaua', 'teste1', '$2y$10$ViRGp08J2tvVBaZmI3.6YORtplA3V1vbix6SHM0Fsgi9wQECErIxG', 'ADMINISTRADOR'),
(2, 'andressa', 'teste2', '$2y$10$q8tFLvilN0BYK2J9VucAP.Er4QQsqMjH50HqGFIxYLJPkgBvfuVeW', 'OPERADOR'),
(3, 'leo', 'teste3', '$2y$10$eAZlTXGIxp73uPFBCRnGCO4FUIHjumZf5yKv5.ceQrKMdFDOIHRpG', 'OPERADOR');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `materiais`
--
ALTER TABLE `materiais`
  ADD PRIMARY KEY (`id_material`);

--
-- Índices de tabela `movimentacoes`
--
ALTER TABLE `movimentacoes`
  ADD PRIMARY KEY (`id_mov`),
  ADD KEY `id_material` (`id_material`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `materiais`
--
ALTER TABLE `materiais`
  MODIFY `id_material` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `movimentacoes`
--
ALTER TABLE `movimentacoes`
  MODIFY `id_mov` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `movimentacoes`
--
ALTER TABLE `movimentacoes`
  ADD CONSTRAINT `movimentacoes_ibfk_1` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id_material`),
  ADD CONSTRAINT `movimentacoes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
