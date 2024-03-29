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
import uts.asd.hsms.model.Feedback;

/**
 *
 * @author Griffin
 */
public class FeedbackValidator {
    private Feedback feedback;
    
    public FeedbackValidator(Feedback feedback) {
        this.feedback = feedback;        
    }
    
    public Feedback getFeedback() {
        return feedback;
    }
    
    public void setFeedback(Feedback feedback) {
        this.feedback = feedback;
    }
    
    public String[] validateFeedback() {
        String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        
        //It validates bean instances
        Validator validator = factory.getValidator();
        
        //Validate bean
        Set<ConstraintViolation<Feedback>> constraintViolations = validator.validate(feedback, ValidatorSequence.class);
        
        //Return an ArrayList of error messages for validations
        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<Feedback> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count++;
            }
            return messages;
        }
        return null;
    }
}
