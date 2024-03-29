/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Message;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.MessagesDao;

/**
 *
 * @author Sukonrat
 */
public class MessagesServlet extends HttpServlet {

    private HttpSession session;
    private MessagesDao messageDao;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ArrayList<String> messages;    
    private ObjectId messageID;
    private String sender, recipient, content;
    private Date date;
    private EmailNotifier emailNotifier;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MessagesServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MessagesServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
        
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //   processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        this.response = response;
        this.request = request;        
        session = request.getSession();
        messageDao = (MessagesDao) session.getAttribute("messageDao");
        messages = new ArrayList<String>();
        emailNotifier = new EmailNotifier();
        String action = request.getParameter("action");        
        
        if (action.equals("Send")) {
            sendMessage();
        } else if (action.equals("New Message")) {
            messageForm();
        } else if (action.equals("Forward")) {
            forwardMessage();
        } else if (action.equals("ForwardEmail")) {
            try {
                forwardEmail();
            } catch (MessagingException ex) {
                Logger.getLogger(MessagesServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("Delete")) {
            deleteMessage();
        } else if (action.equals("Cancel")) {
            cancelMessage();
        } else {
            response.sendRedirect("messages.jsp");
        }
     
    }
    
    private void sendMessage() throws ServletException, IOException {
   
        User user = (User) session.getAttribute("user");
        sender = user.getFirstName();
        recipient = request.getParameter("recipient");
        content = request.getParameter("content");
        Date date = new Date();
        Message message = new Message(null, sender, recipient, content, date);

        messageDao.sendMessage(message.getSender(), message.getRecipient(), message.getContent(), date);
        response.sendRedirect("messages.jsp");
        
    }
    
    private void deleteMessage() throws ServletException, IOException {
  
        messageID = new ObjectId(request.getParameter("messageID"));
        messageDao.deleteMessage(messageID);
        response.sendRedirect("messages.jsp");
    }
    
    private void forwardMessage() throws ServletException, IOException {
     
        User user = (User) session.getAttribute("user");  
        sender = user.getFirstName();     
        recipient = request.getParameter("recipient");
        content = request.getParameter("content");
        Date date = new Date();
        
        Message oldMessage = messageDao.getSingleMessage(messageID); 
        Message newMessage = new Message(messageID, sender, recipient, content, date);
        messageDao.forwardMessage(newMessage.getSender(), newMessage.getRecipient(), newMessage.getContent(), date);
        
        response.sendRedirect("messages.jsp");
        
    }
    private void forwardEmail()throws MessagingException, ServletException, IOException {
        User user = (User) session.getAttribute("user");  
        sender = user.getEmail();
        recipient = request.getParameter("recipient");
        content = request.getParameter("content");
        emailNotifier.sendEmail(recipient, sender, content);
        response.sendRedirect("messages.jsp");
    }
    
    private void messageForm() throws ServletException, IOException {
        response.sendRedirect("messageform.jsp");
    }
    
    private void cancelMessage() throws ServletException, IOException {
        response.sendRedirect("messages.jsp");
    }
    
}
