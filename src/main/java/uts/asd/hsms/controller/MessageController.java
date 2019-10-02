/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import uts.asd.hsms.model.dao.MessagesDao;

/**
 *
 * @author Sukonrat
 */
public class MessageController {
    private MessagesDao messageDao;
    
    public MessageController(HttpSession session){
    messageDao = (MessagesDao)session.getAttribute("messageDao");
    
    }
}
    
    

