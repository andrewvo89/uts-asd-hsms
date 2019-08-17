/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import java.io.Serializable;
import org.bson.types.ObjectId;

public class User implements Serializable {
    
    private ObjectId userId;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String department;
    private int userRole;

    public User(ObjectId userId, String firstName, String lastName, String email, String password, String department, int userRole) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.department = department;
        this.userRole = userRole;
        //userRole
        //1 = Administrator
        //2 = Principle
        //3 = Head Teacher
        //4 = Teacher
    }

    public ObjectId getUserId() {
        return userId;
    }

    public void setUserId(ObjectId userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public int getUserRole() {
        return userRole;
    }

    public void setUserRole(int userRole) {
        this.userRole = userRole;
    }
    public String getUserRoleString() {
        if (userRole == 1) return "Administrator";
        else if (userRole == 2) return "Principal";
        else if (userRole == 3) return "Head Teacher";
        else if (userRole == 4) return "Teacher";
        return null;
    }
    public String getUserIdString() {
        return userId.toString();
    }
    
}
