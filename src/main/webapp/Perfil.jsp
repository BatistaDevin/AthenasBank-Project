<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.crudjspjava.bean.Usuario" %>
<%@ page import="com.crudjspjava.dao.UsuarioDao" %>
<%@ page import="com.crudjspjava.util.ConnectionFactory" %>
<%@ page import="java.sql.Connection" %>

<%
    // Obtém CPF do usuário logado (armazenado na sessão)
    String cpfUsuarioLogado = (String) session.getAttribute("cpfUsuario");

    // Se o CPF não estiver na sessão, significa que o usuário não está logado
    if (cpfUsuarioLogado == null) {
        response.sendRedirect("index.jsp"); // Redireciona para login
        return;
    }

    // Buscar dados do usuário no banco de dados usando o CPF
    Usuario usuario = null;
    try (Connection connection = ConnectionFactory.getConnection()) {
        // Alterado para utilizar o CPF em vez do ID
        usuario = UsuarioDao.getPerfilByCpf(cpfUsuarioLogado);  // Correção aqui (sem os parênteses)
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("erro.jsp");
        return;
    }

    // Se não encontrar o usuário no banco, redireciona para a página de erro
    if (usuario == null) {
        response.sendRedirect("erro.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil do Usuário</title>
    <link rel="stylesheet" href="perfil.css">
</head>
<body>
    <div class="container">
        <!-- Menu Lateral -->
          <div class="sidebar">
            <img src="logo.png" alt="Logo Athenas Bank">
            <h1>Athenas Bank</h1>
            <a href="Perfil.jsp" class="menu-item">Perfil</a>
            <a href="Conta.jsp" class="menu-item">Conta</a>
            <a href="Formulario.jsp" class="menu-item">Solicitações</a>
            <a href="Solicitacoes.jsp" class="menu-item">Cartões</a>
            <a href="Transferencias.jsp" class="menu-item">Transferências</a>
            <a href="chat.jsp" class="menu-item">Chat Bank</a>
            <a href="index.jsp" class="logout">Sair</a>
        </div>

        <!-- Conteúdo -->
        <div class="content">
            <h2>Perfil do Usuário</h2>
            <div class="profile-container">
                <div class="profile-photo">
                    <img src="images/default-avatar.png" alt="Foto do Usuário">
                    <p><a href="#">Alterar Foto</a></p>
                </div>
                <div class="profile-info">
                    <p><strong>Nome:</strong> <%= usuario.getNome() %></p>
                    <p><strong>CPF:</strong> <%= usuario.getCpf() %></p>
                    <p><strong>Número da Conta:</strong> <%= usuario.getNumeroConta() %></p>
                    <p><strong>Agência:</strong> <%= usuario.getAgencia() %></p>
                    <p><strong>País:</strong> <%= usuario.getPais() %></p>
                </div>
            </div>
            <a href="chat.jsp" class="help-button">Precisa de Ajuda? Acesse o Chat</a>
        </div>
    </div>
</body>
</html>
