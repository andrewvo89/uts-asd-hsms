/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.UserDao;

/**
 *
 * @author Andrew
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDao userDao = (UserDao)session.getAttribute("userDao");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");
        User user = userDao.getUser(email, password);

        if (user != null) {
            session.setAttribute("user", user);
            session.removeAttribute("errorMessage");                    
        } else {
            session.setAttribute("errorMessage", "Username or Password Incorrect");                               
        }
        if (redirect == null || redirect.equals("null")) response.sendRedirect("index.jsp");   
        else response.sendRedirect(redirect + ".jsp");
    }
}