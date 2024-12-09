<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.crudjspjava.bean.Usuario" %>
<%@ page import="com.crudjspjava.dao.UsuarioDao" %>
<%@ page import="com.crudjspjava.util.ConnectionFactory" %>
<%@ page import="java.sql.Connection" %>

<%
    // Autenticação: verificar usuário logado
    String cpfUsuarioLogado = (String) session.getAttribute("cpfUsuario");

    if (cpfUsuarioLogado == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Usuario usuario = null;
    try (Connection connection = ConnectionFactory.getConnection()) {
        usuario = UsuarioDao.getPerfilByCpf(cpfUsuarioLogado);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("erro.jsp");
        return;
    }

    if (usuario == null) {
        response.sendRedirect("erro.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Athenas Bank Dashboard</title>
    <link rel="stylesheet" href="perfil.css">
</head>
<body>
    <div class="sidebar">
        <div class="logo-area">
            <img src="Imagens/logo.png" alt="Logo do Banco">
            <div class="bank-name">Athenas Bank</div>
        </div>
        <nav class="nav-links">
            <a href="Perfil.jsp" class="nav-item">
                <img src="vector.png" alt="" class="icon"> Perfil
            </a>
            <a href="Parcelamento.jsp" class="nav-item">
                <img src="carteira.png" alt="" class="icon"> Parcelamento
            </a>
            <a href="Formulario.jsp" class="nav-item">
                <img src="transf.png" alt="" class="icon"> Solicitações
            </a>
            <a href="Solicitacoes.jsp" class="nav-item">
                <img src="vector.png" alt="" class="icon"> Cartões
            </a>
            <a href="Transferencias.jsp" class="nav-item">
                <img src="vector.png" alt="" class="icon"> Transferências
            </a>
            <a href="chat.jsp" class="nav-item">
                <img src="chat.png" alt="" class="icon"> Chat Bank
            </a>
            <div class="profile-section">
                <a href="index.jsp" class="logout">Sair</a>
            </div>
        </nav>
    </div>
    <div class="main-content">
        <div class="profile-card">
            <h2 class="profile-title">Perfil</h2>
            <div class="photo-section">
                <div class="photo-container">
                    <img src="/placeholder.svg" alt="Foto de perfil" class="profile-photo" id="profile-photo">
                    <label for="photo-upload" class="photo-upload-label">📷</label>
                    <input type="file" id="photo-upload" class="photo-upload-input" accept="image/*">
                </div>
                <div class="photo-text">
                    <h3 class="photo-title">Alterar foto</h3>
                    <p class="photo-subtitle">Clique no ícone para atualizar sua foto de perfil</p>
                </div>
            </div>
            <form action="AtualizarPerfilServlet" method="post">
                <div class="form-group">
                    <label for="name" class="form-label">Nome</label>
                    <input type="text" id="name" name="nome" class="form-input" value="<%= usuario.getNome() %>">
                </div>
                <div class="form-group">
                    <label for="cpf" class="form-label">CPF</label>
                    <input type="text" id="cpf" name="cpf" class="form-input" value="<%= usuario.getCpf() %>" readonly>
                </div>
                <div class="form-group">
                    <label for="account" class="form-label">Número da Conta</label>
                    <input type="text" id="account" name="numeroConta" class="form-input" value="<%= usuario.getNumeroConta() %>" readonly>
                </div>
                <div class="form-group">
                    <label for="branch" class="form-label">Agência</label>
                    <input type="text" id="branch" name="agencia" class="form-input" value="<%= usuario.getAgencia() %>" readonly>
                </div>
                <div class="form-group">
                    <label for="country" class="form-label">País</label>
                    <input type="text" id="country" name="pais" class="form-input" value="<%= usuario.getPais() %>">
                </div>
                <button type="submit" class="save-button">Salvar Alterações</button>
            </form>
            <a href="Ajuda.jsp" class="help-link">Precisa de ajuda?</a>
        </div>
    </div>
    <script src="perfil.js"></script>
</body>
</html>
