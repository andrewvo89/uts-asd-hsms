/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.util.ArrayList;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.UserDao;

/**
 *
 * @author Andrew
 */
public class LoginController {
    private UserDao userDao;
    private EmailNotifier emailNotifier = new EmailNotifier();
    
    public LoginController(HttpSession session) {
        userDao = (UserDao)session.getAttribute("userDao");
        emailNotifier = new EmailNotifier();
    }
    
    public boolean checkFailedLogins(String email, ArrayList<String> failedLogins) {
        int count = 0;
        for (String failedLogin : failedLogins) {
            if (failedLogin.equals(email)) {
                count++;
            }
        }//If email is found more then 5 times in the ArrayList, return true
        if (count >= 5) {
            return true;
        }
        return false;
    }
    //Talk to Email Notifier
    public void sendEmail(String recipient, String subject, String body) throws MessagingException {
        emailNotifier.sendEmail(recipient, subject, body);
    }
    
    //Talk to Dao direct to Servlet has to go through Controller
    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, String sort, int order) {
        return userDao.getUsers(userId, firstName, lastName, phone, location, email, password, department, userRole, sort, order);
    }
}
