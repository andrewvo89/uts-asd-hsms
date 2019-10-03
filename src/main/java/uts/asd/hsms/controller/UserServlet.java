/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import uts.asd.hsms.controller.validator.UserValidator;
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
import uts.asd.hsms.model.*;

/**
 *
 * @author Andrew
 */
public class UserServlet extends HttpServlet {
    private UserController controller;
    private HttpSession session;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId userId;
    private String firstName, lastName, phone, location, email, password, department;
    private int userRole;
    private UserValidator userValidator;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();         
        controller = new UserController(session);
        message = new ArrayList<>();
        this.response = response;
        this.request = request;
        //Process POST from usermanagement.jsp or userprofile.jsp
        String action = request.getParameter("action");             
        switch (action) {
            case "add":
                addUser();
                break;        
            case "edit":
                editUser();
                break;
            case "delete":
                deleteUser();
                break;
            default:
                response.sendRedirect("usermanagement.jsp");
                break;
        }
    }
    public void addUser() throws ServletException, IOException {//Initializing variables and cleaning up with Proper Case and trim()
        firstName = controller.toProperCase(request.getParameter("firstNameAdd").trim());
        lastName = controller.toProperCase(request.getParameter("lastNameAdd").trim());
        phone = request.getParameter("phoneAdd").trim();
        location = request.getParameter("locationAdd").trim();
        department = request.getParameter("departmentAdd").trim();
        email = request.getParameter("emailAdd").trim().toLowerCase();
        password = request.getParameter("passwordAdd");
        userRole = Integer.parseInt(request.getParameter("userRoleAdd").trim());
        //User to be added into the Database
        User newUser = new User(null, firstName, lastName, phone, location, email, password, department, userRole, true);
        userValidator = new UserValidator(newUser);//Server Side validations
        String[] errorMessages = userValidator.validateUser();//If Server Side validations have errors
        String addModalErrorMessage = "";
        Boolean addSuccess = false;
        message.add("Add User Result"); 

        //If Errors
        if (errorMessages != null) { addModalErrorMessage = errorMessages[0]; }
        else {//No Errors
            try {
                newUser.setPassword(PasswordEncrypt.generateStorngPasswordHash(password));
                if (controller.addUser(newUser)) addSuccess = true;
            }
            catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
                addModalErrorMessage = ex.getMessage();
            }
        }//Add OK
        if (addSuccess) {
            message.add(String.format("%s %s added successfully", firstName, lastName)); message.add("success"); 
            session.setAttribute("message", message);//Show search results with just email to help indicate record on View
            response.sendRedirect("usermanagement.jsp?emailSearch="+email);   
        }//Error from Try/Catch above
        else {
            message.add(addModalErrorMessage); message.add("danger");  
            session.setAttribute("message", message);
            response.sendRedirect("usermanagement.jsp");
        }
    }
    
    public void editUser() throws ServletException, IOException {//Initialize variables and do some text clean up with ProperCase() & trim()
        User oldUser = null, newUser = null;
        User sessionUser = (User)session.getAttribute("user");//Initialize current session user, original user details, and new user details
        userId = new ObjectId(request.getParameter("userIdEdit"));
        firstName = controller.toProperCase(request.getParameter("firstNameEdit").trim());
        lastName = controller.toProperCase(request.getParameter("lastNameEdit").trim());
        phone = request.getParameter("phoneEdit").trim();
        location = request.getParameter("locationEdit").trim();
        department = request.getParameter("departmentEdit").trim();
        email = request.getParameter("emailEdit").trim().toLowerCase();
        password = request.getParameter("passwordEdit").trim();
        userRole = Integer.parseInt(request.getParameter("userRoleEdit").trim());
        String redirect = request.getParameter("redirect"), redirectEmail;
        String editModalErrorMessage = "";
        Boolean editSuccess = false;
        message.add("Edit User Result");        
        
        //Only proceed if the _userId in question exists in the database
        if (controller.getUsers(userId, null, null, null, null, null, null, null, 0, true, "firstname", 1).length != 0) {
            oldUser = controller.getUsers(userId, null, null, null, null, null, null, null, 0, true, "firstname", 1)[0];
            newUser = new User(userId, firstName, lastName, phone, location, email, password, department, userRole, true);
            userValidator = new UserValidator(newUser);
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
                if (errorMessages != null) editModalErrorMessage = errorMessages[0];
                else {//If no problems with editing user on a database level
                    if (controller.editUser(newUser)) editSuccess = true;
                    else editModalErrorMessage = "Failed to edit User: Database issue";
                }
            }
            catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
                editModalErrorMessage = ex.getMessage();
            }
        }
        else editModalErrorMessage = "Failed to edit User: User does not exist in Database";
        
        //Final setting of Parameters depending on edit success of failure
        if (editSuccess) {//If user trying to edit is the same user that is logged in, update the session user with new details
            if (userId.equals(sessionUser.getUserId())) session.setAttribute("user", newUser);
            message.add(String.format("%s %s edited successfully", newUser.getFirstName(), newUser.getLastName())); message.add("success");
            redirectEmail = newUser.getEmail();
        }
        else {
            message.add(editModalErrorMessage); message.add("danger");
            redirectEmail = oldUser.getEmail();
        }
        session.setAttribute("message", message);//Set success of failure message to display on next page
        if (redirect.equals("userprofile")) response.sendRedirect(redirect + ".jsp");//Redirect to userprofile.jsp page as origin
        else response.sendRedirect("usermanagement.jsp?emailSearch=" + redirectEmail);//Redirect with email search result to show in table
    }
        public void deleteUser() throws ServletException, IOException {
            userId = new ObjectId(request.getParameter("userIdDelete"));//Only perform if userid is found in database
            User sessionUser = (User)session.getAttribute("user");
            boolean deleteSuccess = false;
            message.add("Delete User Result");
            if (controller.getUsers(userId, null, null, null, null, null, null, null, 0, true, "firstname", 1).length != 0) {
                User user = controller.getUsers(userId, null, null, null, null, null, null, null, 0, null, "_id", 1)[0];
                user.setActive(false);
                if (controller.editUser(user)) message.add(String.format("%s %s deleted successfully", user.getFirstName(), user.getLastName())); message.add("success"); deleteSuccess = true;
            }
            if (!deleteSuccess) message.add("Failed to delete user"); message.add("danger");
            //If you deleted yourself, must log you out as session user does not exist anymore, cannot use this account anymore
            if (userId.equals(sessionUser.getUserId())) {
                response.sendRedirect("LogoutServlet");
            }
            else {
                session.setAttribute("message", message);
                response.sendRedirect("usermanagement.jsp");
            }
        }
}
