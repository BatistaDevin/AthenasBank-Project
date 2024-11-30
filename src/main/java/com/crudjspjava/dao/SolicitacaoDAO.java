package com.crudjspjava.dao;

import com.crudjspjava.bean.Solicitacao;
import com.crudjspjava.util.ConnectionFactory;

import java.sql.*;
import java.time.LocalDate;
import java.util.Random;

public class SolicitacaoDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/crudjspjava";
    private static final String USER = "root"; // Substitua pelo seu usuário do MySQL
    private static final String PASSWORD = ""; // Substitua pela sua senha do MySQL

    private Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean salvarSolicitacao(Solicitacao solicitacao) {
        boolean sucesso = false; // Variável para monitorar o status da operação

        try (Connection con = getConnection()) {
            // Calcula limite de crédito
            double limiteCredito = calcularLimiteCredito(solicitacao.getScore(), solicitacao.getRenda());
            // Gera dados do cartão
            String numeroCartao = gerarNumeroCartao();
            String validade = gerarDataValidade();
            String cvv = gerarCVV();

            // Query para inserir dados no banco
            String query = "INSERT INTO solicitacoes (nome, cpf, renda, score, limite, cartao, validade, cvv) "
                         + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, solicitacao.getNome());
            stmt.setString(2, solicitacao.getCpf());
            stmt.setDouble(3, solicitacao.getRenda());
            stmt.setInt(4, solicitacao.getScore());
            stmt.setDouble(5, limiteCredito);
            stmt.setString(6, numeroCartao);
            stmt.setString(7, validade);
            stmt.setString(8, cvv);

            int linhasAfetadas = stmt.executeUpdate(); // Obtém o número de linhas inseridas
            sucesso = (linhasAfetadas > 0); // Define sucesso como true se pelo menos uma linha foi afetada
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            sucesso = false; // Garante que a falha seja registrada
        }

        return sucesso; // Retorna o status da operação
    }


    public Solicitacao buscarSolicitacaoPorCpf(String cpf) {
        Solicitacao solicitacao = null;

        try (Connection con = getConnection()) {
            String query;
            PreparedStatement stmt;

            if (cpf != null && !cpf.isEmpty()) {
                // Consulta pelo CPF, se fornecido
                query = "SELECT * FROM solicitacoes WHERE cpf = ? ORDER BY id DESC LIMIT 1";
                stmt = con.prepareStatement(query);
                stmt.setString(1, cpf);
            } else {
                // Consulta o último registro, caso o CPF não seja fornecido
                query = "SELECT * FROM solicitacoes ORDER BY id DESC LIMIT 1";
                stmt = con.prepareStatement(query);
            }

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                solicitacao = new Solicitacao();
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setNome(rs.getString("nome"));
                solicitacao.setCpf(rs.getString("cpf"));
                solicitacao.setRenda(rs.getDouble("renda"));
                solicitacao.setPretensao(rs.getDouble("pretensao"));
                solicitacao.setScore(rs.getInt("score"));

                // Calcula o limite de crédito
                double limiteCredito = calcularLimiteCredito(solicitacao.getScore(), solicitacao.getRenda());
                solicitacao.setLimiteCredito(limiteCredito);

                solicitacao.setCartao(rs.getString("cartao"));
                solicitacao.setValidade(rs.getString("validade"));
                solicitacao.setCvv(rs.getString("cvv"));
                solicitacao.setAgencia(rs.getString("agencia"));
                solicitacao.setDataSolicitacao(rs.getDate("data_solicitacao"));
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return solicitacao;
    }
    public static double buscarLimite(String cpf) {
        double limite = 0.0;
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT limite FROM solicitacoes WHERE cpf = ?")) {
            ps.setString(1, cpf);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    limite = rs.getDouble("limite");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return limite;
    }



    private double calcularLimiteCredito(int score, double renda) {
        if (score > 200) {
            return renda * 2; // Limite = 2x a renda
        }
        return 0; // Score <= 200, limite 0
    }

    private String gerarNumeroCartao() {
        Random random = new Random();
        StringBuilder numeroCartao = new StringBuilder();

        for (int i = 0; i < 16; i++) {
            numeroCartao.append(random.nextInt(10));
        }

        return numeroCartao.toString();
    }

    private String gerarDataValidade() {
        LocalDate hoje = LocalDate.now();
        LocalDate validade = hoje.plusYears(5); // Validade de 5 anos
        return validade.toString();
    }

    private String gerarCVV() {
        Random random = new Random();
        int cvv = random.nextInt(900) + 100; // Gera um CVV entre 100 e 999
        return String.valueOf(cvv);
    }
}
