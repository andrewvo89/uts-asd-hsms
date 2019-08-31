/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
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
    private String firstName, lastName, phone, location, email, password, department;
    private int userRole;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {         
        session = request.getSession();
        userDao = (UserDao)session.getAttribute("userDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;
        //Process POST from usermanagement.jsp or userprofile.jsp
        String action = request.getParameter("action");             
        if (action.equals("add")) addUser();
        else if (action.equals("edit")) editUser();
        else if (action.equals("delete")) deleteUser();
        else response.sendRedirect("index.jsp");        
    }
    public void addUser() throws ServletException, IOException {//Initializing variables and cleaning up with Proper Case and trim()
        firstName = toProperCase(request.getParameter("firstNameAdd").trim());
        lastName = toProperCase(request.getParameter("lastNameAdd").trim());
        phone = request.getParameter("phoneAdd").trim();
        location = request.getParameter("locationAdd").trim();
        department = request.getParameter("departmentAdd").trim();
        email = request.getParameter("emailAdd").trim().toLowerCase();
        password = request.getParameter("passwordAdd");
        userRole = Integer.parseInt(request.getParameter("userRoleAdd").trim());
        //User to be added into the Database
        User newUser = new User(null, firstName, lastName, phone, location, email, password, department, userRole);
        UserValidator userValidator = new UserValidator(newUser);//Server Side validations
        String[] errorMessages = userValidator.validateUser();//If Server Side validations have errors
        String addModalErrorMessage = "";
        Boolean addSuccess = false;

        //If Errors
        if (errorMessages != null) addModalErrorMessage = errorMessages[0];
        else {//No Errors
            try {
                newUser.setPassword(PasswordEncrypt.generateStorngPasswordHash(password));
                userDao.addUser(newUser);
                addSuccess = true;
            }
            catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
                addModalErrorMessage = ex.getMessage();
            }
        }//Add OK
        if (addSuccess) {
            message.add("Add User Result"); message.add(String.format("%s %s added successfully", firstName, lastName)); message.add("success"); 
            session.setAttribute("message", message);//Show search results with just email to help indicate record on View
            response.sendRedirect("usermanagement.jsp?emailSearch="+email);   
        }//Error from Try/Catch above
        else {
            message.add("Add User Result"); message.add(addModalErrorMessage); message.add("danger");  
            session.setAttribute("message", message);
            response.sendRedirect("usermanagement.jsp");
        }
    }
    
    public void editUser() throws ServletException, IOException {//Initialize variables and do some text clean up with ProperCase() & trim()
        userId = new ObjectId(request.getParameter("userIdEdit"));
        firstName = toProperCase(request.getParameter("firstNameEdit").trim());
        lastName = toProperCase(request.getParameter("lastNameEdit").trim());
        phone = request.getParameter("phoneEdit").trim();
        location = request.getParameter("locationEdit").trim();
        department = request.getParameter("departmentEdit").trim();
        email = request.getParameter("emailEdit").trim().toLowerCase();
        password = request.getParameter("passwordEdit").trim();
        userRole = Integer.parseInt(request.getParameter("userRoleEdit").trim());
        String redirect = request.getParameter("redirect"), redirectEmail;
        //Initialize current session user, original user details, and new user details
        User sessionUser = (User)session.getAttribute("user");
        //Only proceed if the _userId in question exists in the database
        if (userDao.getUsers(userId, null, null, null, null, null, null, null, 0).length > 0) {
            User oldUser = userDao.getUsers(userId, null, null, null, null, null, null, null, 0)[0];
            User newUser = new User(userId, firstName, lastName, phone, location, email, password, department, userRole);
            UserValidator userValidator = new UserValidator(newUser);
            String tempEmail = null;
            try {
                //Clause to eliminate duplicate email flag on validateUser() if email is unchanged
                if (oldUser.getEmail().equals(newUser.getEmail())) {
                    tempEmail = newUser.getEmail();
                    newUser.setEmail("tempemail@hsms.edu.au");
                }
                //If password field is left blank, bypass validation with a temp password
                if (newUser.getPassword().length() == 0) newUser.setPassword("TempP@s$");
                String[] errorMessages = userValidator.validateUser();
                if (newUser.getPassword().equals("TempP@s$")) newUser.setPassword(null);
                else newUser.setPassword(PasswordEncrypt.generateStorngPasswordHash(password));
                //Set email back to the original one
                if (tempEmail != null) newUser.setEmail(tempEmail);
                //If Errors
                if (errorMessages != null) {
                    message.add("Edit User Result"); message.add(errorMessages[0]); message.add("danger");
                    redirectEmail = oldUser.getEmail();
                }//No Errors
                else {
                    userDao.editUser(newUser);
                    //If user trying to edit is the same user that is logged in, update the session user with new details
                    if (userId.equals(sessionUser.getUserId())) session.setAttribute("user", newUser);
                    message.add("Edit User Result"); message.add(String.format("%s %s edited successfully", newUser.getFirstName(), newUser.getLastName())); message.add("success");
                    redirectEmail = newUser.getEmail();
                }
            }
            catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
                message.add("Edit User Result"); ex.getMessage(); message.add("danger");
                redirectEmail = oldUser.getEmail();
            }
        }
        else {
            message.add("Edit User Result"); message.add("Failed to edit user"); message.add("danger");
            redirectEmail = null;
        }
        session.setAttribute("message", message);
        if (redirect.equals("userprofile")) response.sendRedirect(redirect + ".jsp");
        else response.sendRedirect("usermanagement.jsp?emailSearch=" + redirectEmail);//Redirect with email search result to show in table  
    }
        public void deleteUser() throws ServletException, IOException {
            userId = new ObjectId(request.getParameter("userIdDelete"));//Only perform if userid is found in database
            if (userDao.getUsers(userId, null, null, null, null, null, null, null, 0).length > 0) {
                User user = userDao.getUsers(userId, null, null, null, null, null, null, null, 0)[0];
                String deletedUser = user.getFirstName() + " " + user.getLastName();
                userDao.deleteUser(userId);//Call userDao to delete user based on userId
                message.add("Delete User Result"); message.add(String.format("%s deleted successfully", deletedUser)); message.add("success");
            }
            else {
                message.add("Delete User Result"); message.add("Failed to delete user"); message.add("danger");
            }
            session.setAttribute("message", message);
            response.sendRedirect("usermanagement.jsp");
        }
        //Fix First Name and Last Name to be Proper Case
        public String toProperCase(String input) {
            String properCase = "";
            String previousLetter = "";
            input = input.trim();
            for (int x = 0; x < input.length(); x ++) {
                if (x == 0 || previousLetter.equals("-")) properCase += input.substring(x, x + 1).toUpperCase();
                else properCase += input.substring(x, x + 1).toLowerCase();
                previousLetter = input.substring(x, x + 1);
            }
            return properCase;
        }
}
