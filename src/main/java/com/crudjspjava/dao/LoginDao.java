package com.crudjspjava.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {
    private static final String URL = "jdbc:mysql://localhost:3306/crudjspjava";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER_CLASS = "com.mysql.jdbc.Driver";

    static {
        try {
            Class.forName(DRIVER_CLASS);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver JDBC do MySQL não encontrado. Certifique-se de que o driver está no classpath da aplicação.", e);
        }
    }

   
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

  
    public boolean validate(String cpf, String agencia, String password) {
        boolean status = false;
        String query = "SELECT * FROM usuario WHERE cpf = ? AND agencia = ? AND password = ?";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, cpf);
            ps.setString(2, agencia);
            ps.setString(3, password);

            try (ResultSet rs = ps.executeQuery()) {
                status = rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao validar usuário.", e);
        }
        return status;
    }
}
