package uts.asd.hsms.controller;

import java.io.Serializable;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validator implements Serializable{
    private String emailPattern = "([a-zA-Z0-9]+)(([._-])([a-zA-Z0-9]+))*(@)([a-z]+)(.)([a-z]{3})((([.])[a-z]{0,2})*)";   
    private String namePattern = "([A-Z][a-z]+[\\s])+[A-Z][a-z]*";    
    private String passwordPattern = "[a-z]{6,}[0-9]+";    
    private HashMap<String,String> errors;
    
    public Validator(){ 
        errors = new HashMap();
    }
    
    public void add(String key, String err){
        errors.put(key, err);
    }
    
    public boolean validate(String pattern, String input){
        Pattern regEx = Pattern.compile(pattern);
        Matcher match = regEx.matcher(input);
        return match.matches();
    }
    
    public boolean checkEmpty(String email, String password){
        return  email.isEmpty() || password.isEmpty();
    }
    public boolean validateEmail(String email){                
        return validate(emailPattern,email);
    }
    
    public boolean validateName(String name){        
        return validate(namePattern,name);
    }
    
    public boolean validatePassword(String password){        
        return validate(passwordPattern,password);
    }
       
    public HashMap errors(){
        return errors;
    }
    
    public void clearLogs(){
        errors.clear();
    }
    
    public String error(String key){
        
        for(Map.Entry<String,String> e:errors.entrySet()){
            if(e.getKey().equals(key))
                return e.getValue();
        }
        return null;
    } 
    
    private void showErrors()
    {
        System.out.println("Size = "+errors.size());
        for(Map.Entry<String,String> e:errors.entrySet()){
            System.out.println(e.getValue());
        }
    }
       
}
