<%@ page import="com.crudjspjava.bean.Usuario,com.crudjspjava.dao.UsuarioDao" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Athenas Bank - Cadastro</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="left-side">
        <img src="Imagens/logo.png" alt="Logo do Banco">
        <div class="bank-name">Athenas Bank</div>
        <p class="instructions">
            Após a conclusão do seu cadastro, você receberá um e-mail de confirmação contendo o número da sua conta e sua agência, que serão utilizados para efetuar o login.
        </p>
    </div>

    <div class="right-side">
        <h1 class="form-title">Cadastre-se</h1>

        <!-- Mensagem de erro ou sucesso -->
        <% 
            String message = "";
            try {
                String nome = request.getParameter("nome");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String sexo = request.getParameter("sexo");
                String pais = request.getParameter("pais");
                String cpf = request.getParameter("cpf");

                if (nome != null && cpf != null) {
                    Usuario usuario = new Usuario();
                    usuario.setNome(nome);
                    usuario.setPassword(password);
                    usuario.setEmail(email);
                    usuario.setSexo(sexo);
                    usuario.setPais(pais);
                    usuario.setCpf(cpf);

                    int status = UsuarioDao.salvarUsuario(usuario);

                    if (status == -1) {
                        message = "<div class='alert alert-danger'>Erro: CPF já cadastrado!</div>";
                    } else if (status > 0) {
                        message = "<div class='alert alert-success'>Usuário cadastrado com sucesso!</div>";
                    } else {
                        message = "<div class='alert alert-danger'>Erro ao cadastrar. Tente novamente.</div>";
                    }
                }
            } catch (Exception e) {
                message = "<div class='alert alert-danger'>Erro ao processar o cadastro: " + e.getMessage() + "</div>";
            }
        %>
        <%= message %>

        <!-- Formulário de Cadastro -->
        <form action="usuarioform.jsp" method="post">
            <div class="form-group">
                <input type="text" name="nome" class="form-control" placeholder="Nome Completo" required />
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="Senha" required />
            </div>
            <div class="form-group">
                <input type="email" name="email" class="form-control" placeholder="E-mail" required />
            </div>
            <div class="form-group">
                <input type="text" name="cpf" class="form-control" placeholder="CPF" required pattern="\d{11}" title="Digite um CPF válido com 11 números" />
            </div>
            <div class="form-group">
                <label>Sexo:</label>
                <input type="radio" name="sexo" value="masculino" required /> Masculino
                <input type="radio" name="sexo" value="feminino" required /> Feminino
            </div>
            <div class="form-group">
                <select name="pais" class="form-control" required>
                    <option value="Brasil">Brasil</option>
                    <option value="EUA">EUA</option>
                    <option value="Portugal">Portugal</option>
                    <option value="Argentina">Argentina</option>
                    <option value="Outro">Outro</option>
                </select>
            </div>
            <button type="submit" class="login-button">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10z"/>
                    <path d="M8 12l3 3 6-6"/>
                </svg>
                FINALIZAR CADASTRO
            </button>
            <div class="login-link">
                Já tem conta? <a href="index.jsp">Conecte-se</a>
            </div>
        </form>
    </div>
</body>
</html>
