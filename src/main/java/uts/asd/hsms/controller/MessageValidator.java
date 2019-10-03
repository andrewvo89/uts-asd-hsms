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
import uts.asd.hsms.model.Message;

/**
 *
 * @author Sukonrat
 */
public class MessageValidator {
    
    private Message message;
    
    public MessageValidator(Message message){
        this.message = message;
    }
    public void setMessage(Message message){
        this.message = message;
    }
    public Message getMessage(){
        return message;
    }
    public String[] validateMessage(){
        
    String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
         
        //It validates bean instances
        Validator validator = factory.getValidator();
        
        //Validate bean
        Set<ConstraintViolation<Message>> constraintViolations = validator.validate(message);

        
        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<Message> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count ++;
            }
            return messages;
        }
        return null;
    }
}
