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
        
        String action = request.getParameter("action");        
        
        if (action.equals("Send")) {
            sendMessage();
        } else if (action.equals("New Message")) {
            messageForm();
        } else if (action.equals("Forward")) {
            forwardMessage();
        } else if (action.equals("Delete")) {
            deleteMessage();
        } else if (action.equals("Cancel")) {
            cancelMessage();
        } else {
            response.sendRedirect("messages.jsp");
        }
        //   processRequest(request, response);
    }
    
    private void sendMessage() throws ServletException, IOException {
        User user = (User) session.getAttribute("user");
        sender = user.getFirstName();
        recipient = request.getParameter("recipient");
        content = request.getParameter("content");
        Date date = new Date();
        
        Message message = new Message(null, sender, recipient, content, date);
        messageDao.sendMessage(message.getSender(), message.getRecipient(), message.getContent(), date);
        // System.out.print("message has been sent successfully");  
        response.sendRedirect("messages.jsp");
        
    }
    
    private void deleteMessage() throws ServletException, IOException {
        messageID = new ObjectId(request.getParameter("messageID"));
        //   Message[] message = messageDao.getMessage();
        
        messageDao.deleteMessage(messageID);
        
        response.sendRedirect("messages.jsp");
    }
    
    private void forwardMessage() throws ServletException, IOException {
        Message oldMessage = null;
        Message newMessage = null;
        User user = (User) session.getAttribute("user");  
        sender = user.getFirstName();
        messageID = new ObjectId(request.getParameter("messageID"));        
        recipient = request.getParameter("recipient");
        content = request.getParameter("content");
        Date date = new Date();
        
       oldMessage = messageDao.getSingleMessage(messageID); 
        newMessage = new Message(null, sender, recipient, content, date);

     //    messageDao.forwardMessage(newMessage.getMessageID() ,newMessage.getSender(),newMessage.getRecipient(), newMessage.getContent(), date);
        messageDao.forwardMessage(newMessage);
        
        response.sendRedirect("messages.jsp");
        
    }
    
    private void messageForm() throws ServletException, IOException {
        response.sendRedirect("messageform.jsp");
    }
    
    private void cancelMessage() throws ServletException, IOException {
        response.sendRedirect("messages.jsp");
    }
    
}
