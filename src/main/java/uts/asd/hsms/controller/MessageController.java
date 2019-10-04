/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;


import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Message;
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
    
    public Message[] getMessage(ObjectId messageID, String sender, String recipient, String title, String content, Date date){
    return messageDao.getMessages(messageID, sender, recipient, title, content, date);
    }
}
    
    

