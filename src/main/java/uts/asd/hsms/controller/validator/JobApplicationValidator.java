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
import uts.asd.hsms.model.JobApplication;
public class JobApplicationValidator {
    private JobApplication jobApplication;
    
    public JobApplicationValidator(JobApplication jobApplication) {
        this.jobApplication = jobApplication;
    }
    
    public JobApplication getJobApplication() {
        return jobApplication;
    }

    public void setjobApplication(JobApplication jobApplication) {
        this.jobApplication = jobApplication;
    }
    
    public String[] validateJobApplication() {
        String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
         
        //It validates bean instances
        Validator validator = factory.getValidator();
        
        //Validate bean
        Set<ConstraintViolation<JobApplication>> constraintViolations = validator.validate(jobApplication, ValidatorSequence.class);

        //Return an ArrayList of error messages for validations
        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<JobApplication> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count ++;
            }
            return messages;
        }
        return null;
    }
}
