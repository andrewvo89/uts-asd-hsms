/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;
import com.mongodb.MongoClient;
import java.net.UnknownHostException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.MongoDBConnector;
import uts.asd.hsms.model.dao.UserDao;

/**
 *
 * @author Admin
 */
public class EmailValidator implements ConstraintValidator<EmailConstraint, String> {

    
    @Override
    public void initialize(EmailConstraint email) {
    }
 
    @Override
    public boolean isValid(String email, ConstraintValidatorContext cxt) {
        MongoDBConnector mongoDbConnector = null;  
        UserDao userDao;
        MongoClient mongoClient;
        
        try {
            mongoDbConnector = new MongoDBConnector(); 
        } catch (UnknownHostException ex) {
            Logger.getLogger(ConnServlet.class.getName()).log(Level.SEVERE, null, ex);
        }  
        mongoClient = mongoDbConnector.openConnection();
        userDao = new UserDao(mongoClient);
        User[] users = userDao.getUsers(null, null, null, null, null, null, null, null, 0);
        for (int x = 0; x < users.length; x ++) {
            if (users[x].getEmail().equals(email)){
                mongoDbConnector.closeConnection();
                return false;
            }
        }
        mongoDbConnector.closeConnection();
        return true;
    }
 
}
