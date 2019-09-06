/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import uts.asd.hsms.controller.EmailConstraint;
import java.io.Serializable;
import org.bson.types.ObjectId;
import javax.validation.constraints.Size;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

public class User implements Serializable {
    
    private ObjectId userId;
    @NotEmpty(message = "Please enter First Name")
    @Size(min = 1, max = 32, message = "Last Name must be between 1 and 32 Characters")
    private String firstName;
    @NotEmpty(message = "Please enter Last Name")
    @Size(min = 1, max = 32, message = "Last Name must be between 1 and 32 Characters")
    private String lastName;
    @NotEmpty(message = "Please enter Phone")
    @Size(min = 1, max = 10, message = "Phone must be between 1 and 10 Characters")
    @Pattern(regexp = "^[0-9]*$", message = "Phone must include numbers only")
    private String phone;
    @NotEmpty(message = "Please enter Location")
    @Size(min = 1, max = 16, message = "Location must be between 1 and 16 Characters")
    private String location;
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

    public User(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.location = location;
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

    public User(String phone, String location) {
        this.phone = phone;
        this.location = location;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
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
