<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.crudjspjava.dao.SolicitacaoDAO" %>
<%@ page import="com.crudjspjava.bean.Solicitacao" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chat do Banco Digital</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="chat.css">
</head>
<body>
    <div class="container">
        <!-- Menu Lateral -->
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo do Banco">
            <h1>Athenas Bank</h1>
            <a href="Perfil.jsp" class="menu-item">Perfil</a>
            <a href="Parcelamento.jsp" class="menu-item">Parcelamento</a>
            <a href="Formulario.html" class="menu-item">Solicitações</a>
            <a href="Solicitacoes.jsp" class="menu-item">Cartões</a>
            <a href="Transferencias.jsp" class="menu-item">Transferências</a>
            <a href="chat.jsp" class="menu-item">Chat Bank</a>
            <a href="index.jsp" class="logout">Sair</a>
        </div>

        <!-- Conteúdo Principal -->
        <div class="content">
            <h2>Chat do Banco Digital</h2>

            <!-- Área do Chat -->
            <div class="chat-container">
                <div class="chat-history">
                    <%
                        // Recupera o histórico do chat
                        String chatHistory = (String) session.getAttribute("chatHistory");
                        if (chatHistory == null) {
                            chatHistory = "<div class='chat-message system-message'><strong>Banco:</strong> Olá! Para prosseguir, informe o seu CPF.</div>";
                        }

                        // Inicializa o DAO para consultas
                        SolicitacaoDAO dao = new SolicitacaoDAO();
                        String userInput = request.getParameter("userInput");
                        String cpf = (String) session.getAttribute("cpf");

                        if (userInput != null && !userInput.trim().isEmpty()) {
                            userInput = userInput.trim();
                            // Adiciona a mensagem do usuário ao histórico
                            chatHistory += "<div class='chat-message user-message'><strong>Você:</strong> " + userInput + "</div>";

                            String systemResponse = "";

                            // Verifica se o CPF foi informado
                            if (cpf == null) {
                                // Validar o CPF informado
                                if (userInput.matches("\\d{11}")) {
                                    cpf = userInput;
                                    session.setAttribute("cpf", cpf);
                                    Solicitacao solicitacao = dao.buscarSolicitacaoPorCpf(cpf);
                                    if (solicitacao != null) {
                                        systemResponse = "CPF validado com sucesso! Como posso te ajudar hoje? Escolha uma opção:<br>" +
                                                         "1. Ver seu limite de crédito<br>" +
                                                         "2. Saber seu score com o banco<br>" +
                                                         "3. Ver número da conta<br>" +
                                                         "4. Ver validade do cartão<br>" +
                                                         "5. Ver data de solicitação do crédito<br>" +
                                                         "6. Sair";
                                    } else {
                                        systemResponse = "Nenhuma solicitação encontrada para este CPF. Tente novamente.";
                                        session.setAttribute("cpf", null); // Remove o CPF inválido
                                    }
                                } else {
                                    systemResponse = "CPF inválido. Por favor, digite um CPF válido com 11 dígitos.";
                                }
                            } else {
                                Solicitacao solicitacao = dao.buscarSolicitacaoPorCpf(cpf);

                                if (solicitacao == null) {
                                    systemResponse = "Erro ao acessar informações do CPF. Por favor, tente novamente.";
                                } else {
                                    switch (userInput.toLowerCase()) {
                                        case "1":
                                            systemResponse = "Seu limite de crédito aprovado é de R$ " + solicitacao.getLimiteCredito() + ".";
                                            break;
                                        case "2":
                                            systemResponse = "Seu score com o banco é: " + solicitacao.getScore() + ".";
                                            break;
                                        case "3":
                                            systemResponse = "Seu número de conta é: " + solicitacao.getCartao() + ".";
                                            break;
                                        case "4":
                                            systemResponse = "A validade do seu cartão é: " + solicitacao.getValidade() + ".";
                                            break;
                                        case "5":
                                            systemResponse = "A data de solicitação do crédito foi: " + solicitacao.getDataSolicitacao() + ".";
                                            break;
                                        case "6":
                                            systemResponse = "Até logo! Foi um prazer ajudá-lo.";
                                            chatHistory += "<div class='chat-message system-message'><strong>Banco:</strong> " + systemResponse + "</div>";
                                            session.invalidate();
                                            response.sendRedirect("TelaPrincipal.html");
                                            return;
                                        default:
                                            systemResponse = "Comando inválido. Por favor, digite um número entre 1 e 6.";
                                            break;
                                    }
                                }
                            }

                            // Adiciona a resposta do sistema ao histórico
                            chatHistory += "<div class='chat-message system-message'><strong>Banco:</strong> " + systemResponse + "</div>";
                            session.setAttribute("chatHistory", chatHistory);
                        }
                    %>
                    <%= chatHistory %>
                </div>

                <!-- Formulário de Envio -->
                <form class="chat-form" method="post" action="chat.jsp">
                    <input type="text" name="userInput" placeholder="Digite aqui..." required>
                    <input type="submit" value="Enviar">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
