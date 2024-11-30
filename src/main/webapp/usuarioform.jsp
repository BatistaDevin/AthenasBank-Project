<%@ page import="com.crudjspjava.bean.Usuario,com.crudjspjava.dao.UsuarioDao" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Usuário</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <div class="left-section">
            <h1>Bem-vindo!</h1>
            <p>Cadastre-se para ter acesso a conteúdo exclusivo.</p>
        </div>

        <div class="right-section">
            <h2>Cadastre-se</h2>

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
                    <label>Nome:</label>
                    <input type="text" name="nome" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>Senha:</label>
                    <input type="password" name="password" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" class="form-control" required />
                </div>
                <div class="form-group">
                    <label>CPF:</label>
                    <input type="text" name="cpf" class="form-control" required pattern="\d{11}" title="Digite um CPF válido com 11 números" />
                </div>
                <div class="form-group">
                    <label>Sexo:</label>
                    <input type="radio" name="sexo" value="masculino" required /> Masculino
                    <input type="radio" name="sexo" value="feminino" required /> Feminino
                </div>
                <div class="form-group">
                    <label>País:</label>
                    <select name="pais" class="form-control" required>
                        <option value="Brasil">Brasil</option>
                        <option value="EUA">EUA</option>
                        <option value="Portugal">Portugal</option>
                        <option value="Argentina">Argentina</option>
                        <option value="Outro">Outro</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Cadastrar</button>
                <a href="index.jsp" class="btn btn-secondary">Ir para Login</a>
        </div>
    </div>
</body>
</html>
