package com.crudjspjava.servlet;

import com.crudjspjava.dao.LoginDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;  // Importação necessária
import jakarta.servlet.RequestDispatcher; // Importação necessária
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        String cpf = request.getParameter("cpf");
        String agencia = request.getParameter("agencia");
        String password = request.getParameter("password");

       
        LoginDao loginDao = new LoginDao();
        boolean isValid = loginDao.validate(cpf, agencia, password);

        if (isValid) {
            
            HttpSession session = request.getSession();
            session.setAttribute("cpfUsuario", cpf);
            response.sendRedirect("TelaPrincipal.html"); 
        } else {
           
            request.setAttribute("errorMessage", "Credenciais inválidas.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }
}
