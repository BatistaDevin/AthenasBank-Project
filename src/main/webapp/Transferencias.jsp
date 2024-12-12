<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.crudjspjava.dao.SolicitacaoDAO" %>
<%@ page import="com.crudjspjava.bean.Solicitacao" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transações</title>
    <link rel="stylesheet" href="transferencias.css">
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
            <h2>Extrato Bancário</h2>
            <div class="transacoes">
                <h3>Transações</h3>
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
                        <!-- Dados de Exemplo -->
                        <tr>
                            <td>Débito</td>
                            <td>18/11/2024</td>
                            <td>Farmácia GHI</td>
                            <td>R$ 50,00</td>
                        </tr>
                        <tr>
                            <td>Débito</td>
                            <td>17/11/2024</td>
                            <td>Posto JKL</td>
                            <td>R$ 200,00</td>
                        </tr>
                        <tr>
                            <td>Crédito</td>
                            <td>15/11/2024</td>
                            <td>Cinema MNO</td>
                            <td>R$ 80,00</td>
                        </tr>
                       
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
