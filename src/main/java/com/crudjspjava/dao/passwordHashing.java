package com.crudjspjava.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class passwordHashing {
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            // Tratar a exceção, como lançar uma exceção personalizada ou logar o erro
            throw new RuntimeException("Algoritmo de hash não encontrado.", e);
        }
    }
}
