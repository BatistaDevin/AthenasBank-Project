<%@ page import="com.crudjspjava.dao.LoginDao" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class="background-image">
    <div class="container">
        <div class="left-section">
            <h1>Bem-vindo ao Athenas Bank</h1>
            <p>Entre com seu CPF e senha para acessar sua conta.</p>
        </div>
        
        <div class="right-section">
            <h2>Login</h2>

            <% 
            // Verifica se há mensagem de erro na requisição (caso tenha falhado o login)
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
                out.println("<div class='alert alert-danger' role='alert'>" + errorMessage + "</div>");
            }
            %>

            <!-- Formulário de Login -->
            <form method="post" action="login"> <!-- Ação alterada para /login -->
                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <input type="text" class="form-control" id="cpf" name="cpf" placeholder="Digite seu CPF" required>
                </div>
                <div class="form-group">
                    <label for="agencia">Agência:</label>
                    <input type="text" class="form-control" id="agencia" name="agencia" value="0001" readonly>
                </div>
                <div class="form-group">
                    <label for="password">Senha:</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Digite sua senha" required>
                </div>
                <button type="submit" class="btn btn-primary">Entrar</button>
            </form>
        </div>
    </div>
</body>
</html>
