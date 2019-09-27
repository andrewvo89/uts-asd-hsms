/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.UserDao;

/**
 *
 * @author Andrew
 */
public class UserController {
    private UserDao userDao;
    
    public UserController(HttpSession session) {
        userDao = (UserDao)session.getAttribute("userDao");
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
    //Get checked radio button for department
    public String[] getDepartmentSearch(String department) {
        String[] departmentSearch = new String[6];
        for (int x = 0; x < departmentSearch.length; x ++) { departmentSearch[x] = ""; }
        if (department == null) department = ""; departmentSearch[0] = "checked";
        if (department.equals("Administration")) departmentSearch[1] = "checked";
        if (department.equals("English")) departmentSearch[2] = "checked";
        if (department.equals("Math")) departmentSearch[3] = "checked";
        if (department.equals("Science")) departmentSearch[4] = "checked";
        if (department.equals("Art")) departmentSearch[5] = "checked";
        return departmentSearch;
    }
    //Get checked radio button for user role
    public String[] getUserRoleSearch(int userRole) {
        String[] uerRoleSearch = new String[5];
        for (int x = 0; x < uerRoleSearch.length; x ++) { uerRoleSearch[x] = ""; }
        if (userRole == 0) uerRoleSearch[0] = "checked";
        if (userRole == 1) uerRoleSearch[1] = "checked";
        if (userRole == 2) uerRoleSearch[2] = "checked";
        if (userRole == 3) uerRoleSearch[3] = "checked";
        if (userRole == 4) uerRoleSearch[4] = "checked";
        return uerRoleSearch;
    }
    //Get checked radio button for department
    public String[] getDepartmentEdit(String department) {
        String[] departmentEdit = new String[5];
        for (int x = 0; x < departmentEdit.length; x ++) { departmentEdit[x] = ""; }
        if (department.equals("Administration")) departmentEdit[0] = "checked";
        if (department.equals("English")) departmentEdit[1] = "checked";
        if (department.equals("Math")) departmentEdit[2] = "checked";
        if (department.equals("Science")) departmentEdit[3] = "checked";
        if (department.equals("Art")) departmentEdit[4] = "checked";
        return departmentEdit;
    }
    //Get checked radio button for user role
    public String[] getUserRoleEdit(int userRole) {
        String[] uerRoleEdit = new String[4];
        for (int x = 0; x < uerRoleEdit.length; x ++) { uerRoleEdit[x] = ""; }
        if (userRole == 1) uerRoleEdit[0] = "checked";
        if (userRole == 2) uerRoleEdit[1] = "checked";
        if (userRole == 3) uerRoleEdit[2] = "checked";
        if (userRole == 4) uerRoleEdit[3] = "checked";
        return uerRoleEdit;
    }
    //Convert int to string value for user role
    public String getUserRoleString(int userRole) {
        if (userRole == 1) return "Administrator";
        else if (userRole == 2) return "Principal";
        else if (userRole == 3) return "Head Teacher";
        else if (userRole == 4) return "Teacher";
        return null;
    }
    
    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, Boolean active, String sort, int order) {
        return userDao.getUsers(userId, firstName, lastName, phone, location, email, password, department, userRole, active, sort, order);
    }
        public boolean addUser(User user) {
        return userDao.addUser(user);
    }
    public boolean editUser(User user) {
        return userDao.editUser(user);
    }
    public boolean deleteUser(User user) {
        return userDao.deleteUser(user);
    }
}
