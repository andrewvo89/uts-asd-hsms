/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;
import java.util.Set;
 
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import uts.asd.hsms.model.Attendance;

/**
 *
 * @author Griffin
 */
public class AttendanceValidator {
    private Attendance attendance;
    
    public AttendanceValidator(Attendance attendance){
        this.attendance = attendance;
    }
    
    public Attendance getAttendance() {
        return attendance;
    }
    
    public void setAttendance(Attendance attendance){
        this.attendance = attendance;
    }
    
    public String[] validateAttendace() {
        String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
         
        //It validates bean instances
        Validator validator = factory.getValidator();
        
        //Validate bean
        Set<ConstraintViolation<Attendance>> constraintViolations = validator.validate(attendance);

        
        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<Attendance> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count ++;
            }
            return messages;
        }
        return null;
        
    }
}
