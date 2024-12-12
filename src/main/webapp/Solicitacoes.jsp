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
            <h2>Cartões</h2>

           
            <div class="cartoes-container">
                <%
                   
                    String cpfUsuarioLogado = (String) session.getAttribute("cpfUsuario");

                    if (cpfUsuarioLogado == null) {
                        response.sendRedirect("index.jsp"); 
                    } else {
                        SolicitacaoDAO dao = new SolicitacaoDAO();
                        Solicitacao solicitacao = dao.buscarSolicitacaoPorCpf(cpfUsuarioLogado); 

                        if (solicitacao != null) {
                %>
                            <div class="cartao">
    <div class="cartao-imagem">
        <div class="cartao-info">
            <p><strong>Número:</strong> <%= solicitacao.getCartao() %></p>
            <p><strong>CVV:</strong> <%= solicitacao.getCvv() %></p>
            <p><strong>Validade:</strong> <%= solicitacao.getValidade() %></p>
            <p><strong>Limite:</strong> R$ <%= String.format("%.2f", solicitacao.getLimiteCredito()) %></p>
            <p><strong>Agência:</strong> 0001</p>
        </div>
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
            

                
            
             <div class="transactions-section">
                <h3 class="transactions-title">Transações Recentes</h3>
                <table class="transactions-table">
                    <thead>
                        <tr>
                            <th>Data</th>
                            <th>Descrição</th>
                            <th>Tipo</th>
                            <th>Valor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>15/05/2023</td>
                            <td>Depósito</td>
                            <td><span class="transaction-type transaction-type-credit">Crédito</span></td>
                            <td>R$ 1.000,00</td>
                        </tr>
                        <tr>
                            <td>14/05/2023</td>
                            <td>Supermercado XYZ</td>
                            <td><span class="transaction-type transaction-type-debit">Débito</span></td>
                            <td>R$ 250,30</td>
                        </tr>
                        <tr>
                            <td>13/05/2023</td>
                            <td>Transferência para João</td>
                            <td><span class="transaction-type transaction-type-debit">Débito</span></td>
                            <td>R$ 500,00</td>
                        </tr>
                        <tr>
                            <td>12/05/2023</td>
                            <td>Salário</td>
                            <td><span class="transaction-type transaction-type-credit">Crédito</span></td>
                            <td>R$ 3.500,00</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
