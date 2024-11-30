package com.crudjspjava.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.crudjspjava.bean.Usuario;

public class UsuarioDao {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/crudjspjava", "root", "");
        } catch (Exception e) {
            System.out.println(e);
        }
        return con;
    }

    // Método para verificar se o CPF já existe
    public static boolean isCpfExists(String cpf) {
        boolean exists = false;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM usuario WHERE cpf = ?")) {
            ps.setString(1, cpf);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return exists;
    }

    // Método para salvar usuário com validação de CPF duplicado
    public static int salvarUsuario(Usuario u) {
        int status = 0;
        if (isCpfExists(u.getCpf())) {
            System.out.println("Erro: O CPF já está cadastrado no sistema.");
            return -1; // Indica que o CPF já existe
        }
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO usuario (nome, password, email, sexo, pais, cpf) VALUES (?, ?, ?, ?, ?, ?)")) {
            ps.setString(1, u.getNome());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getSexo());
            ps.setString(5, u.getPais());
            ps.setString(6, u.getCpf());
            status = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return status;
    }

    // Método para buscar usuário por ID
    public static Usuario getRegistroById(int id) {
        Usuario usuario = null;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNome(rs.getString("nome"));
                    usuario.setPassword(rs.getString("password"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setSexo(rs.getString("sexo"));
                    usuario.setPais(rs.getString("pais"));
                    usuario.setCpf(rs.getString("cpf"));
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return usuario;
    }

    // Método para listar todos os usuários
    public static List<Usuario> getAllUsuarios() {
        List<Usuario> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setPassword(rs.getString("password"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSexo(rs.getString("sexo"));
                usuario.setPais(rs.getString("pais"));
                usuario.setCpf(rs.getString("cpf"));
                list.add(usuario);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    // Método para atualizar usuário
    public static int updateUsuario(Usuario u) {
        int status = 0;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE usuario SET nome = ?, password = ?, email = ?, sexo = ?, pais = ?, cpf = ? WHERE id = ?")) {
            ps.setString(1, u.getNome());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getSexo());
            ps.setString(5, u.getPais());
            ps.setString(6, u.getCpf());
            ps.setInt(7, u.getId());
            status = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return status;
    }
 // Método para buscar dados completos do perfil por ID
 // Método alterado para buscar dados completos do perfil por CPF
    public static Usuario getPerfilByCpf(String cpf) {
        Usuario usuario = null;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE cpf = ?")) {
            ps.setString(1, cpf);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNome(rs.getString("nome"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setSexo(rs.getString("sexo"));
                    usuario.setPais(rs.getString("pais"));
                    usuario.setCpf(rs.getString("cpf"));
                    usuario.setAgencia(rs.getString("agencia"));

                    // Gerar um número de conta único baseado no CPF
                    String numeroConta = gerarNumeroConta(cpf);
                    usuario.setNumeroConta(numeroConta);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return usuario;
    }

    // Método para gerar um número de conta baseado no CPF
    private static String gerarNumeroConta(String cpf) {
        // Aqui é gerado um número simples a partir do CPF, garantindo que seja único para o mesmo CPF
        // Esse método pode ser aprimorado para algo mais complexo, mas a ideia é gerar algo simples
        int numeroConta = cpf.hashCode(); // Converte o CPF para um hash inteiro
        if (numeroConta < 0) {
            numeroConta = -numeroConta; // Garante que o número da conta seja positivo
        }
        return String.format("%08d", numeroConta); // Formata para 8 dígitos
    }
    



}
