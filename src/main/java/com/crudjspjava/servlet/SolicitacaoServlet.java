package com.crudjspjava.servlet;

import com.crudjspjava.bean.Solicitacao;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Random;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;


public class SolicitacaoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L; 

    private static final String URL = "jdbc:mysql://localhost:3306/crudjspjava";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

   
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            throw new SQLException("Erro ao conectar ao banco de dados.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
      
        Solicitacao solicitacao = new Solicitacao();

       
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        double renda = Double.parseDouble(request.getParameter("renda"));
        int score = Integer.parseInt(request.getParameter("score"));
        String ocupacao = request.getParameter("ocupacao");
        double pretensao = Double.parseDouble(request.getParameter("pretensao"));
        String imovel = request.getParameter("imovel"); 
        String veiculo = request.getParameter("veiculo");
        String outrosBens = request.getParameter("outrosBens");

        
        solicitacao.setNome(nome);
        solicitacao.setCpf(cpf);
        solicitacao.setRenda(renda);
        solicitacao.setScore(score);
        solicitacao.setOcupacao(ocupacao);
        solicitacao.setPretensao(pretensao);
        solicitacao.setImovel(imovel); 
        solicitacao.setVeiculo(veiculo);
        solicitacao.setOutrosBens(outrosBens);

        
        try (Connection con = getConnection()) {
            
            double limiteCredito = calcularLimiteCredito(solicitacao.getScore(), solicitacao.getRenda());
            
            String numeroCartao = gerarNumeroCartao();
            String validade = gerarDataValidade();
            String cvv = gerarCVV();

            
            String query = "INSERT INTO solicitacoes (nome, cpf, renda, score, limite, cartao, validade, cvv, ocupacao, pretensao, imovel, veiculo, outros_bens) "
                         + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setString(1, solicitacao.getNome());
                stmt.setString(2, solicitacao.getCpf());
                stmt.setDouble(3, solicitacao.getRenda());
                stmt.setInt(4, solicitacao.getScore());
                stmt.setDouble(5, limiteCredito);
                stmt.setString(6, numeroCartao);
                stmt.setString(7, validade);
                stmt.setString(8, cvv);
                stmt.setString(9, solicitacao.getOcupacao());
                stmt.setDouble(10, solicitacao.getPretensao());
                stmt.setString(11, solicitacao.getImovel()); // 
                stmt.setString(12, solicitacao.getVeiculo());
                stmt.setString(13, solicitacao.getOutrosBens());

                int linhasAfetadas = stmt.executeUpdate(); 
                if (linhasAfetadas > 0) {
                    
                    request.setAttribute("mensagem", "Solicitação salva com sucesso!");
                } else {
                    
                    request.setAttribute("mensagem", "Erro ao salvar a solicitação. Tente novamente.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("mensagem", "Erro ao processar a solicitação. Detalhes: " + e.getMessage());
        }

        
        request.getRequestDispatcher("Formulario.jsp").forward(request, response);
    }

    private double calcularLimiteCredito(int score, double renda) {
        if (score > 200) {
            return renda * 2; 
        }
        return 0; 
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
        LocalDate validade = hoje.plusYears(5); 
        return validade.toString();
    }

    private String gerarCVV() {
        Random random = new Random();
        int cvv = random.nextInt(900) + 100; 
        return String.valueOf(cvv);
    }
}
