<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicita��o de Cr�dito - Athenas Bank</title>
    <!-- Link para o arquivo CSS externo -->
    <link rel="stylesheet" href="Formulario.css">
</head>
<body>
    <div class="container">
        <!-- Menu Lateral -->
        <div class="sidebar">
            <img src="logo.png" alt="Logo Athenas Bank">
            <h1>Athenas Bank</h1>
            <a href="Perfil.jsp" class="menu-item">Perfil</a>
            <a href="Conta.jsp" class="menu-item">Conta</a>
            <a href="Formulario.jsp" class="menu-item">Solicita��es</a>
            <a href="Solicitacoes.jsp" class="menu-item">Cart�es</a>
            <a href="#" class="menu-item">Transfer�ncias</a>
            <a href="chat.jsp" class="menu-item">Chat Bank</a>
            <a href="index.jsp" class="logout">Sair</a>
        </div>

        <!-- Conte�do Principal -->
        <div class="content">
            <h2>Solicita��o de Cr�dito</h2>

            <!-- Exibir a mensagem de status -->
            <% 
                String mensagem = request.getAttribute("mensagem") != null ? (String) request.getAttribute("mensagem") : ""; 
            %>
            <div class="mensagem"><%= mensagem %></div>

            <form id="credit-form" action="SolicitacaoServlet" method="post">
                <div class="form-left">
                    <!-- Informa��es Pessoais -->
                    <label for="nome">Nome Completo</label>
                    <input type="text" id="nome" name="nome" required>

                    <label for="cpf">CPF</label>
                    <input type="text" id="cpf" name="cpf" maxlength="11" required>

                    <label for="score">Score de Cr�dito</label>
                    <input type="number" id="score" name="score" min="0" max="1000" required>

                    <!-- Renda e Ocupa��o -->
                    <label for="renda">Renda Mensal (R$)</label>
                    <input type="number" id="renda" name="renda" min="0" step="0.01" required>

                    <label for="ocupacao">Ocupa��o</label>
                    <select id="ocupacao" name="ocupacao" required>
                        <option value="">Selecione</option>
                        <option value="empregado">Empregado</option>
                        <option value="autonomo">Aut�nomo</option>
                        <option value="estudante">Estudante</option>
                        <option value="desempregado">Desempregado</option>
                    </select>

                    <!-- Pretens�o de Cr�dito -->
                    <label for="pretensao">Pretens�o de Cr�dito (R$)</label>
                    <input type="number" id="pretensao" name="pretensao" min="0" step="0.01" required>
                </div>

                <!-- Lateral para Propriedades Declaradas -->
                <div class="form-right">
                    <h3>Propriedades Declaradas</h3>

                    <label for="imovel">Im�vel residencial?</label>
                    <select id="imovel" name="imovel" required>
                        <option value="nao">N�o</option>
                        <option value="sim">Sim</option>
                    </select>

                    <label for="veiculo">Ve�culo automotor?</label>
                    <textarea id="veiculo" name="veiculo" rows="2" placeholder="Descreva o ve�culo, se houver..."></textarea>

                    <label for="outros-bens">Outros bens?</label>
                    <textarea id="outros-bens" name="outrosBens" rows="3" placeholder="Descreva outros bens, se houver..."></textarea>
                </div>

                <button type="submit" class="btn-finalizar">Finalizar</button>
            </form>
        </div>
    </div>

    <script>
        // Valida��o simples para os campos antes do envio
        document.getElementById('credit-form').addEventListener('submit', function(event) {
            const nome = document.getElementById('nome').value;
            const cpf = document.getElementById('cpf').value;
            const renda = document.getElementById('renda').value;
            const ocupacao = document.getElementById('ocupacao').value;
            const pretensao = document.getElementById('pretensao').value;

            if (!(nome && cpf && renda && ocupacao && pretensao)) {
                event.preventDefault(); // Impede o envio se algum campo estiver vazio
                alert("Por favor, preencha todos os campos.");
            }
        });
    </script>

</body>
</html>
