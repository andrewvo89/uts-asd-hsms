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
import uts.asd.hsms.model.UserAudit;

/**
 *
 * @author Sukonrat
 */
public class LogValidator {
    private UserAudit userAudit;
    
    public LogValidator (UserAudit userAudit){
    this.userAudit=userAudit;
    }
    
    public UserAudit getUserAudit(){
    return userAudit;
    }
    public void setUserAudit(UserAudit userAudit){
     this.userAudit=userAudit;
    }
    public String[] validateLog(){
     String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
         
        //It validates bean instances
        Validator validator = factory.getValidator();
        
        //Validate bean
        Set<ConstraintViolation<UserAudit>> constraintViolations = validator.validate(userAudit);

        
        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<UserAudit> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count ++;
            }
            return messages;
        }
        return null;
        
    }
    
}
