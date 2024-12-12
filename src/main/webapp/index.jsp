<%@ page import="com.crudjspjava.dao.LoginDao" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Athenas Bank - Login</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="left-side">
        <img src="Imagens/logo.png" alt="Logo do Banco">
        <div class="bank-name">Athenas Bank</div>
        <p class="instructions">
            Entre com seu CPF e senha para acessar sua conta e gerenciar suas finanças com segurança.
        </p>
    </div>

    <div class="right-side">
        <h1 class="form-title">Login</h1>

        <% 
        
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            out.println("<div class='alert alert-danger' role='alert'>" + errorMessage + "</div>");
        }
        %>

        
        <form method="post" action="login">
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
                <button type="submit" class="login-button">Entrar</button>
            </form>
        </div>

</body>
</html>
