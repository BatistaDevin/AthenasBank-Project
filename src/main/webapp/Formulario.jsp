<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicita��o de Cr�dito - Athenas Bank</title>
    <link rel="stylesheet" href="Formulario.css">
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
                <img src="vector.png" alt="" class="icon"> In�cio
            </a>
            <a href="Perfil.jsp" class="nav-item">
                <img src="vector.png" alt="" class="icon"> Perfil
            </a>
            <a href="Parcelamento.jsp" class="nav-item">
                <img src="carteira.png" alt="" class="icon"> Parcelamento
            </a>
            <a href="Formulario.jsp" class="nav-item">
                <img src="transf.png" alt="" class="icon"> Solicita��es
            </a>
            <a href="Solicitacoes.jsp" class="nav-item">
                <img src="vector.png" alt="" class="icon"> Cart�es
            </a>
            <a href="Transferencias.jsp" class="nav-item">
                <img src="vector.png" alt="" class="icon"> Transfer�ncias
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
            <h2>Solicita��o de Cr�dito</h2>

           
            <% 
                String mensagem = request.getAttribute("mensagem") != null ? (String) request.getAttribute("mensagem") : ""; 
            %>
            <div class="mensagem"><%= mensagem %></div>

            <form id="credit-form" action="SolicitacaoServlet" method="post">
                <div class="form-left">
                   
                    <label for="nome">Nome Completo</label>
                    <input type="text" id="nome" name="nome" required>

                    <label for="cpf">CPF</label>
                    <input type="text" id="cpf" name="cpf" maxlength="11" required>

                    <label for="score">Score de Cr�dito</label>
                    <input type="number" id="score" name="score" min="0" max="1000" required>

                  
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

                  
                    <label for="pretensao">Pretens�o de Cr�dito (R$)</label>
                    <input type="number" id="pretensao" name="pretensao" min="0" step="0.01" required>
                </div>

                
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
       
        document.getElementById('credit-form').addEventListener('submit', function(event) {
            const nome = document.getElementById('nome').value;
            const cpf = document.getElementById('cpf').value;
            const renda = document.getElementById('renda').value;
            const ocupacao = document.getElementById('ocupacao').value;
            const pretensao = document.getElementById('pretensao').value;

            if (!(nome && cpf && renda && ocupacao && pretensao)) {
                event.preventDefault(); 
                alert("Por favor, preencha todos os campos.");
            }
        });
    </script>
</body>
</html>
