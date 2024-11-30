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
        <!-- Menu Lateral -->
        <div class="sidebar">
            <img src="logo.png" alt="Logo do Banco">
            <h1>Athenas Bank</h1>
            <a href="Perfil.jsp" class="menu-item">Perfil</a>
            <a href="Parcelamento.jsp" class="menu-item">Parcelamento</a>
            <a href="Formulario.jsp" class="menu-item">Solicitações</a>
            <a href="Solicitacoes.jsp" class="menu-item">Cartões</a>
            <a href="Transferencias.jsp" class="menu-item">Transferências</a>
            <a href="chat.jsp" class="menu-item">Chat Bank</a>
            <a href="index.jsp" class="logout">Sair</a>
        </div>

        <!-- Conteúdo Principal -->
        <div class="content">
            <h2>Simulação de Parcelamento</h2>

            <%
                // Obtém o CPF do usuário logado da sessão
                String cpfUsuarioLogado = (String) session.getAttribute("cpfUsuario");

                if (cpfUsuarioLogado == null) {
                    response.sendRedirect("index.jsp"); // Redireciona se não estiver autenticado
                }

                // Busca o limite com base no CPF
                double limite = SolicitacaoDAO.buscarLimite(cpfUsuarioLogado);
            %>

            <p>Seu limite disponível: <strong>R$ <%= String.format("%.2f", limite) %></strong></p>

            <!-- Formulário para selecionar o número de parcelas -->
            <form action="Parcelamento.jsp" method="POST">
                <label for="parcelas">Selecione o número de parcelas (1 a 12):</label>
                <select name="parcelas" id="parcelas" required>
                    <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>"><%= i %> vezes</option>
                    <% } %>
                </select>
                <button type="submit">Simular Parcelamento</button>
            </form>

            <!-- Cálculo das parcelas -->
            <%
                String parcelasParam = request.getParameter("parcelas");
                if (parcelasParam != null) {
                    int parcelas = Integer.parseInt(parcelasParam);
                    double valorParcela = limite / parcelas;

                    out.println("<h3>Extrato de Parcelamento:</h3>");
                    out.println("<ul>");
                    for (int i = 1; i <= parcelas; i++) {
                        out.println("<li>Parcela " + i + ": R$ " + String.format("%.2f", valorParcela) + "</li>");
                    }
                    out.println("</ul>");
                }
            %>
        </div>
    </div>
</body>
</html>
