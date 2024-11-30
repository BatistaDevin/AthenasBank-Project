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
        <!-- Menu Lateral -->
        <div class="sidebar">
            <img src="logo.png" alt="Logo do Banco">
            <h1>Athenas Bank</h1>
            <a href="Perfil.jsp" class="menu-item">Perfil</a>
            <a href="Conta.jsp" class="menu-item">Conta</a>
            <a href="Formulario.jsp" class="menu-item">Solicitações</a>
            <a href="Solicitacoes.jsp" class="menu-item">Cartões</a>
            <a href="Transferencias.jsp" class="menu-item">Transferências</a>
            <a href="chat.jsp" class="menu-item">Chat Bank</a>
            <a href="index.jsp" class="logout">Sair</a>
        </div>

        <!-- Conteúdo Principal -->
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
                        <tr>
                            <td>Crédito</td>
                            <td>20/11/2024</td>
                            <td>Livraria DEF</td>
                            <td>R$ 120,00</td>
                        </tr>
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
                        <tr>
                            <td>Débito</td>
                            <td>14/11/2024</td>
                            <td>Padaria PQR</td>
                            <td>R$ 30,00</td>
                        </tr>
                        <tr>
                            <td>Crédito</td>
                            <td>13/11/2024</td>
                            <td>Shopping STU</td>
                            <td>R$ 500,00</td>
                        </tr>
                        <tr>
                            <td>Débito</td>
                            <td>12/11/2024</td>
                            <td>Academia VWX</td>
                            <td>R$ 100,00</td>
                        </tr>
                        <tr>
                            <td>Crédito</td>
                            <td>10/11/2024</td>
                            <td>Viagem YZ</td>
                            <td>R$ 1.200,00</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
