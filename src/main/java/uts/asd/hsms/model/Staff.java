/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import uts.asd.hsms.controller.validator.EmailConstraint;
import java.io.Serializable;
import org.bson.types.ObjectId;
import javax.validation.constraints.Size;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

public class Staff implements Serializable {
    
    private ObjectId staffId;
    @NotEmpty(message = "Please enter First Name")
    @Size(min = 1, max = 32, message = "Last Name must be between 1 and 32 Characters")
    private String firstName;
    @NotEmpty(message = "Please enter Last Name")
    @Size(min = 1, max = 32, message = "Last Name must be between 1 and 32 Characters")
    private String lastName;
    @NotEmpty(message = "Please enter email")
    @Email(message = "Email Address is invalid")
    @Pattern(regexp = "^[A-Za-z0-9._-]+@hsms.edu.au$", message = "Email Address must end in @hsms.edu.au")
    @EmailConstraint(message = "Email Address is already registered on HSMS")
    private String email;
    @NotEmpty(message = "Please enter Password")
    @Size(min = 6, max = 16, message = "Password must be between 6 and 36 Characters")
    @Pattern(regexp = "^.*(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=\\S+$).*$", message = "Password must contain at least 1 Lower Case, 1 Upper Case and 1 Special Character")
    private String password;
    private String department;
    private int userRole;

    public Staff(ObjectId staffId, String firstName, String lastName, String email, String password, String department, int userRole) {
        this.staffId = staffId;
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

    public ObjectId getstaffId() {
        return staffId;
    }

    public void setstaffId(ObjectId staffId) {
        this.staffId = staffId;
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
    public String getstaffIdString() {
        return staffId.toString();
    }
    
}
