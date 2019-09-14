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
import uts.asd.hsms.model.Staff;
import uts.asd.hsms.model.dao.*;

/**
 *
 * @author alvin
 */
public class StaffValidator {
    private Staff staff;
    
    public StaffValidator(Staff staff) {
        this.staff = staff;
    }
    
    public Staff getstaff() {
        return staff;
    }

    public void setstaff(Staff staff) {
        this.staff = staff;
    }
    
    public String[] validatestaff() {
        String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
         
        //It validates bean instances
        Validator validator = factory.getValidator();
        
        //Validate bean
        Set<ConstraintViolation<Staff>> constraintViolations = validator.validate(staff);

        
        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<Staff> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count ++;
            }
            return messages;
        }
        return null;
    }
}
