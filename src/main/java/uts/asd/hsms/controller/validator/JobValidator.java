/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller.validator;

import java.util.Set; 
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
/**
 *
 * @author Andrew
 */
import uts.asd.hsms.model.Job;
public class JobValidator {
    private Job job;
    
    public JobValidator(Job job) {
        this.job = job;
    }
    
    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }
    
    public String[] validateJob() {
        String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
         
        //It validates bean instances
        Validator validator = factory.getValidator();
        
        //Validate bean
        Set<ConstraintViolation<Job>> constraintViolations = validator.validate(job, ValidatorSequence.class);

        //Return an ArrayList of error messages for validations
        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<Job> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count ++;
            }
            return messages;
        }
        return null;
    }
}
