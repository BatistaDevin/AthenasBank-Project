<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.crudjspjava.dao.SolicitacaoDAO" %>
<%@ page import="com.crudjspjava.bean.Solicitacao" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cartões e Transações</title>
    <link rel="stylesheet" href="Solicitacoes.css">
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
            <h2>Cartões</h2>

            <!-- Seção de Cartões -->
            <div class="cartoes-container">
                <%
                    // Obtém CPF do usuário logado (armazenado na sessão)
                    String cpfUsuarioLogado = (String) session.getAttribute("cpfUsuario");

                    if (cpfUsuarioLogado == null) {
                        response.sendRedirect("index.jsp"); // Redireciona para login se não estiver autenticado
                    } else {
                        SolicitacaoDAO dao = new SolicitacaoDAO();
                        Solicitacao solicitacao = dao.buscarSolicitacaoPorCpf(cpfUsuarioLogado); // Busca os dados com base no CPF

                        if (solicitacao != null) {
                %>
                            <div class="cartao">
                                <div class="cartao-info">
                                    <p><strong>Número:</strong> <%= solicitacao.getCartao() %></p>
                                    <p><strong>CVV:</strong> <%= solicitacao.getCvv() %></p>
                                    <p><strong>Validade:</strong> <%= solicitacao.getValidade() %></p>
                                    <p><strong>Limite:</strong> R$ <%= String.format("%.2f", solicitacao.getLimiteCredito()) %></p>
                                    <p><strong>Agência:</strong> 1234</p>
                                </div>
                            </div>
                <%
                        } else {
                %>
                            <p>Nenhuma solicitação encontrada para o seu CPF.</p>
                <%
                        }
                    }
                %>
            </div>

            <!-- Seção de Transações -->
            <div class="transacoes">
                <h3>Útimios Gastos</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Tipo</th>
                            <th>Data</th>
                            <th>Descrição</th>
                            <th>Valor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Exemplo de transações estáticas -->
                        <tr>
                            <td>Débito</td>
                            <td>25/11/2024</td>
                            <td>Supermercado XYZ</td>
                            <td>R$ 150,00</td>
                        </tr>
                        <tr>
                            <td>Crédito</td>
                            <td>23/11/2024</td>
                            <td>Loja ABC</td>
                            <td>R$ 400,00</td>
                        </tr>
                        <tr>
                            <td>Débito</td>
                            <td>21/11/2024</td>
                            <td>Restaurante 123</td>
                            <td>R$ 80,00</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
