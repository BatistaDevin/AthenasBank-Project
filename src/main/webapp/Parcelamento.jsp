<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.crudjspjava.dao.SolicitacaoDAO" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parcelamento</title>
    <link rel="stylesheet" href="parcelamento.css">
</head>
<body>
    <div class="container">
      
        <div class="sidebar">
            <div class="logo-area">
                <img src="Imagens/logo.png" alt="Logo do Banco">
                <div class="bank-name">Athenas Bank</div>
            </div>
            <nav class="nav-links">
                <a href="TelaPrincipal.html" class="nav-item">
                    <img src="vector.png" alt="" class="icon"> Início
                </a>
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

     
        <div class="content">
            <h2>Simulação de Parcelamento</h2>

            <%
                String cpfUsuarioLogado = (String) session.getAttribute("cpfUsuario");
                if (cpfUsuarioLogado == null) {
                    response.sendRedirect("index.jsp");
                }

                double limite = SolicitacaoDAO.buscarLimite(cpfUsuarioLogado);
            %>

            <p>Seu limite disponível: <strong>R$ <%= String.format("%.2f", limite) %></strong></p>

            <!-- Formulário para Simulação -->
            <form action="Parcelamento.jsp" method="POST">
                <label for="parcelas">Selecione o número de parcelas (1 a 12):</label>
                <select name="parcelas" id="parcelas" required>
                    <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>"><%= i %> vezes</option>
                    <% } %>
                </select>
                <button type="submit">Simular Parcelamento</button>
            </form>

          
            <%
                String parcelasParam = request.getParameter("parcelas");
                if (parcelasParam != null) {
                    int parcelas = Integer.parseInt(parcelasParam);
                    double valorParcela = limite / parcelas;
            %>
            <div class="extrato">
                <h3>Extrato de Parcelamento:</h3>
                <ul>
                    <% for (int i = 1; i <= parcelas; i++) { %>
                        <li>Parcela <%= i %>: R$ <%= String.format("%.2f", valorParcela) %></li>
                    <% } %>
                </ul>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>
