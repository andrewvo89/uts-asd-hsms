/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.dao.*;
import uts.asd.hsms.model.*;

/**
 *
 * @author ADMIN
 */
public class UserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserAddServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserAddServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //processRequest(request, response);          
        HttpSession session = request.getSession();
        UserDao userDao = (UserDao)session.getAttribute("userDao");
        String action = request.getParameter("action");
        
        ArrayList<String> message = new ArrayList<String>(); 
        
        if (action.equals("add")) {
            String firstName = request.getParameter("firstNameAdd");
            String lastName = request.getParameter("lastNameAdd");
            String department = request.getParameter("departmentAdd");
            String email = request.getParameter("emailAdd");
            String password = request.getParameter("passwordAdd");
            int userRole = Integer.parseInt(request.getParameter("userRoleAdd"));

            User user = new User(null, firstName, lastName, email, password, department, userRole);
            UserValidator userValidator = new UserValidator(user);
            String[] errorMessages = userValidator.validateUser();

            //If Errors
            if (errorMessages != null) {
                session.setAttribute("firstNameAdd", firstName);
                session.setAttribute("lastNameAdd", lastName);
                session.setAttribute("emailAdd", email);
                session.setAttribute("passwordAdd", password);
                session.setAttribute("departmentAdd", department);
                session.setAttribute("userRoleAdd", userRole);
                session.setAttribute("message", message);
                message.add("Add User Result"); message.add(errorMessages[0]); message.add("danger"); message.add("addModal");
                response.sendRedirect("usermanagement.jsp");
            }//No Errors
            else {
                userDao.addUser(firstName, lastName, email, password, department, userRole);
                message.add("Add User Result"); message.add(String.format("%s %s added successfully", firstName, lastName)); message.add("success"); message.add("messageModal");
                session.setAttribute("message", message);
                response.sendRedirect("usermanagement.jsp?emailSearch="+email);
            }
        } else if (action.equals("edit")) {
            User sessionUser = (User)session.getAttribute("user");
            ObjectId userId = new ObjectId(request.getParameter("userIdEdit"));
            String firstName = request.getParameter("firstNameEdit");
            String lastName = request.getParameter("lastNameEdit");
            String department = request.getParameter("departmentEdit");
            String email = request.getParameter("emailEdit");
            String password = request.getParameter("passwordEdit");
            int userRole = Integer.parseInt(request.getParameter("userRoleEdit"));
            String redirect = request.getParameter("redirect");
            
            User oldUser = userDao.getUser(userId);
            User newUser = new User(null, firstName, lastName, email, password, department, userRole);           
            UserValidator userValidator = new UserValidator(newUser);
            
            String tempEmail = null;
            //If Errors
            if (oldUser.getEmail().equals(newUser.getEmail())) {
                tempEmail = newUser.getPassword();
                newUser.setEmail("placeholder@hsms.edu.au");
            }
            String[] errorMessages = userValidator.validateUser();
            if (tempEmail != null) newUser.setEmail(tempEmail);
            
            if (errorMessages != null) {
                message.add("Edit User Result"); message.add(errorMessages[0]); message.add("danger"); message.add("messageModal");
                session.setAttribute("message", message);
            }//No Errors
            else {
                userDao.editUser(userId, firstName, lastName, email, password, department, userRole);
                message.add("Edit User Result"); message.add(String.format("%s %s edited successfully", firstName, lastName)); message.add("success"); message.add("messageModal");
                session.setAttribute("message", message);
            }
            
            if (userId.equals(sessionUser.getUserId())) session.setAttribute("user", new User(userId, firstName, lastName, email, password, department, userRole));
            response.sendRedirect(redirect + ".jsp");
        }
        else if (action.equals("delete")) {
            ObjectId userId = new ObjectId(request.getParameter("userIdDelete"));
            User user = userDao.getUser(userId);
            userDao.deleteUser(userId);
            message.add("Delete User Result"); message.add(String.format("%s %s deleted successfully", user.getFirstName(), user.getLastName())); message.add("success"); message.add("messageModal");
            session.setAttribute("message", message);
            response.sendRedirect("usermanagement.jsp");
        }
    }
}
