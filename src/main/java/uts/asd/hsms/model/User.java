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
import uts.asd.hsms.controller.validator.*;

public class User implements Serializable {
    
    private ObjectId userId;
    @Pattern(regexp = "^[A-Za-z-]{1,32}$", message = "<h5 class=\"alert-heading\">First Name Error</h5><hr>"
            + "Cannot be blank<br>"
            + "No more than 32 Characters<br>"
            + "Contains Letters or Special Characters: - only<hr>"
            + "Accepted First Names: Carlos, Kim-Soo<br>"
            + "Rejected First Names: C@rlos, Kim.Soo", groups = ValidatorGroupA.class)
    private String firstName;
    @Pattern(regexp = "^[A-Za-z-]{1,32}$", message = "<h5 class=\"alert-heading\">Last Name Error</h5><hr>"
            + "Cannot be blank<br>"
            + "No more than 32 Characters<br>"
            + "Contains Letters or Special Character: - only<hr>"
            + "Accepted Examples: Delarosa, Anne-Smith<br>"
            + "Rejected Examples: Delaro$a, Anne.Smith", groups = ValidatorGroupB.class)
    private String lastName;
    @Pattern(regexp = "^[+]*[0-9]{1,12}$", message = "<h5 class=\"alert-heading\">Phone Number Error</h5><hr>"
            + "Cannot be blank<br>"
            + "No more than 12 Digits<br>"
            + "Contains numbers  or Special Character: + only<hr>"
            + "Accepted Examples: 0466978467, +6148866412<br>"
            + "Rejected Examples: 02-9746-4581, +61+2+4445", groups = ValidatorGroupC.class)
    private String phone;
    @Pattern(regexp = "^[A-Za-z0-9]{1}[A-Za-z0-9-.]{1,32}$", message = "<h5 class=\"alert-heading\">Location Error</h5><hr>"
            + "Cannot be blank<br>"
            + "No more than 32 Characters<br>"
            + "Contains letters, numbers  or Special Characters: -. only<hr>"
            + "Accepted Examples: CB01.05.203, Building 1 Room 5-23<br>"
            + "Rejected Examples: CB01_05_203, Building 5 Only!!!", groups = ValidatorGroupD.class)
    private String location;
    @Pattern(regexp = "^[A-Za-z0-9._-]{1,52}+@hsms.edu.au$", message = "<h5 class=\"alert-heading\">Email Error</h5><hr>"
            + "Cannot be blank<br>"
            + "No more than 64 Characters<br>"
            + "Contains Letters, Numbers or Special Characters: -_. only<br>"
            + "Must end in @hsms.edu.au<hr>"
            + "Accepted Examples: carlos@hsms.edu.au, carlos.delarosa@hsms.edu.au<br>"
            + "Rejected Examples: carlos@gmail.com, c@rlos@outlooks.com", groups = ValidatorGroupE.class)
    @EmailConstraint(message = "<h5 class=\"alert-heading\">Email Error</h5><hr>"
            + "Email Address is alredy registered on HSMS<br>"
            + "Must be unique", groups = ValidatorGroupF.class)
    private String email;
    @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{6,16}$", message = "<h5 class=\"alert-heading\">Password Error</h5><hr>"
            + "Must contain at least 1 Lower Case Character<br>"
            + "Must contain at least 1 Upper Case Character<br>"
            + "Must contain at least 1 Special Character: @$!%*?&<br>"
            + "Must contain between 6 and 16 Characters<hr>"
            + "Accepted Examples: t!$sUeP@peR, Dogf00d!<br>"
            + "Rejected Examples: password, p@ss", groups = ValidatorGroupG.class)
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
