/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
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
 * @author Andrew
 */
public class UserServlet extends HttpServlet {
    private HttpSession session;
    private UserDao userDao;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId userId;
    private String firstName, lastName, email, password, department;
    private int userRole;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //processRequest(request, response);          
        session = request.getSession();
        userDao = (UserDao)session.getAttribute("userDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;

        String action = request.getParameter("action");             
        if (action.equals("add")) addUser();
        else if (action.equals("edit")) editUser();
        else if (action.equals("delete")) deleteUser();
        else response.sendRedirect("index.jsp");        
    }
    public void addUser() throws ServletException, IOException { 
        firstName = toProperCase(request.getParameter("firstNameAdd"));
        lastName = toProperCase(request.getParameter("lastNameAdd"));
        department = request.getParameter("departmentAdd");
        email = request.getParameter("emailAdd").toLowerCase();
        password = request.getParameter("passwordAdd");
        userRole = Integer.parseInt(request.getParameter("userRoleAdd"));

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
    }
    
    public void editUser() throws ServletException, IOException {
        userId = new ObjectId(request.getParameter("userIdEdit"));
        firstName = toProperCase(request.getParameter("firstNameEdit"));
        lastName = toProperCase(request.getParameter("lastNameEdit"));
        department = request.getParameter("departmentEdit");
        email = request.getParameter("emailEdit").toLowerCase();
        password = request.getParameter("passwordEdit");
        userRole = Integer.parseInt(request.getParameter("userRoleEdit"));
        String redirect = request.getParameter("redirect");
        
        User sessionUser = (User)session.getAttribute("user");
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
        public void deleteUser() throws ServletException, IOException {
            userId = new ObjectId(request.getParameter("userIdDelete"));
            User user = userDao.getUser(userId);
            userDao.deleteUser(userId);
            message.add("Delete User Result"); message.add(String.format("%s %s deleted successfully", user.getFirstName(), user.getLastName())); message.add("success"); message.add("messageModal");
            session.setAttribute("message", message);
            response.sendRedirect("usermanagement.jsp");
        }
        
        public static String toProperCase(String input) {
            String properCase = "";
            String previousLetter = "";
            for (int x = 0; x < input.length(); x ++) {
                if (x == 0 || previousLetter.equals("-")) properCase += input.substring(x, x + 1).toUpperCase();
                else properCase += input.substring(x, x + 1).toLowerCase();
                previousLetter = input.substring(x, x + 1);
            }
            return properCase;
        }
}
