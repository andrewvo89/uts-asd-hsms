/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import java.io.Serializable;
import java.util.*;
import org.bson.types.ObjectId;

/**
 *
 * @author MatthewHellmich
 */
public class Leave implements Serializable {
    private ObjectId leaveId;
    private String firstName;
    private String lastName;
    private String email;
    private String leaveType;
    private Date leaveTo;
    private Date leaveFrom;
    private String Department;

    public Leave(ObjectId leaveId, String firstName, String lastname, String email, String leaveType, Date leaveTo, Date leaveFrom, String Department) {
        this.leaveId = leaveId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.leaveType = leaveType;
        this.leaveTo = leaveTo;
        this.leaveFrom = leaveFrom;
        this.Department = Department;
    }

    public ObjectId getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(ObjectId leaveId) {
        this.leaveId = leaveId;
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

    public void setLastName(String lastname) {
        this.lastName = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public Date getLeaveTo() {
        return leaveTo;
    }

    public void setLeaveTo(Date leaveTo) {
        this.leaveTo = leaveTo;
    }

    public Date getLeaveFrom() {
        return leaveFrom;
    }

    public void setLeaveFrom(Date leaveFrom) {
        this.leaveFrom = leaveFrom;
    }

    public String getDepartment() {
        return Department;
    }

    public void setDepartment(String Department) {
        this.Department = Department;
    }
    
    
}
