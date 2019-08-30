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
 * @author alvin
 */
public class staffdirectoryServlet extends HttpServlet {
    private HttpSession session;
    private staffDao staffDao;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId staffId;
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
        staffDao = (staffDao)session.getAttribute("staffDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;

        String action = request.getParameter("action");             
        if (action.equals("add")) addstaff();
        else if (action.equals("edit")) editstaff();
        else if (action.equals("delete")) deletestaff();
        else response.sendRedirect("index.jsp");        
    }
    public void addstaff () throws ServletException, IOException { 
        firstName = toProperCase(request.getParameter("firstNameAdd"));
        lastName = toProperCase(request.getParameter("lastNameAdd"));
        department = request.getParameter("departmentAdd");
        email = request.getParameter("emailAdd").toLowerCase();
        password = request.getParameter("passwordAdd");
        userRole = Integer.parseInt(request.getParameter("userRoleAdd"));

        Staff staff = new Staff(null, firstName, lastName, email, password, department, userRole);
        staffValidator staffValidator = new staffValidator(staff);
        String[] errorMessages = staffValidator.validatestaff();

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
            staffDao.addstaff(firstName, lastName, email, password, department, userRole);
            message.add("Add User Result"); message.add(String.format("%s %s added successfully", firstName, lastName)); message.add("success"); message.add("messageModal");
            session.setAttribute("message", message);
            response.sendRedirect("staffdirectory.jsp?emailSearch="+email);
        }
    }
    
    public void editstaff() throws ServletException, IOException {
        staffId = new ObjectId(request.getParameter("staffIdEdit"));
        firstName = toProperCase(request.getParameter("firstNameEdit"));
        lastName = toProperCase(request.getParameter("lastNameEdit"));
        department = request.getParameter("departmentEdit");
        email = request.getParameter("emailEdit").toLowerCase();
        password = request.getParameter("passwordEdit");
        userRole = Integer.parseInt(request.getParameter("userRoleEdit"));
        String redirect = request.getParameter("redirect");
        
        Staff sessionStaff = (Staff)session.getAttribute("staff");
        Staff oldStaff = staffDao.getstaff(staffId);
        Staff newStaff = new Staff(null, firstName, lastName, email, password, department, userRole);           
        staffValidator staffValidator = new staffValidator(newStaff);

        String tempEmail = null;
        //If Errors
        if (oldStaff.getEmail().equals(newStaff.getEmail())) {
            tempEmail = newStaff.getPassword();
            newStaff.setEmail("placeholder@hsms.edu.au");
        }
        String[] errorMessages = staffValidator.validatestaff();
        if (tempEmail != null) newStaff.setEmail(tempEmail);

        if (errorMessages != null) {
            message.add("Edit User Result"); message.add(errorMessages[0]); message.add("danger"); message.add("messageModal");
            session.setAttribute("message", message);
        }//No Errors
        else {
            staffDao.editstaff(staffId, firstName, lastName, email, password, department, userRole);
            message.add("Edit User Result"); message.add(String.format("%s %s edited successfully", firstName, lastName)); message.add("success"); message.add("messageModal");
            session.setAttribute("message", message);
        }

        if (staffId.equals(sessionStaff.getstaffId())) session.setAttribute("staff", new Staff(staffId, firstName, lastName, email, password, department, userRole));
        response.sendRedirect(redirect + ".jsp");
    }
        public void deletestaff() throws ServletException, IOException {
            staffId = new ObjectId(request.getParameter("staffIdDelete"));
            Staff staff = staffDao.getstaff(staffId);
            staffDao.deletestaff(staffId);
            message.add("Delete User Result"); message.add(String.format("%s %s deleted successfully", staff.getFirstName(), staff.getLastName())); message.add("success"); message.add("messageModal");
            session.setAttribute("message", message);
            response.sendRedirect("staffdirectory.jsp");
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
