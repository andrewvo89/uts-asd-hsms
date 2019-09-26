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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Message;
import uts.asd.hsms.model.dao.MessageDao;

/**
 *
 * @author Sukonrat
 */
//@WebServlet("/MessagesServlet")

public class MessagesServlet extends HttpServlet {
 private HttpSession session;
    private MessageDao messageDao;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ArrayList<String> messages; 
    private ObjectId messageID;
    private String sender, recipient, title, content;
    private Date sendDate;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
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
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        
        session = request.getSession();
        messageDao = (MessageDao)session.getAttribute("messageDao");
        messages = new ArrayList<String>();
        String action = request.getParameter("action");             
        if (action.equals("send")) sendMessage();
        else if (action.equals("edit")) editMessage();
        else if (action.equals("delete")) deleteMessage();
        else response.sendRedirect("messageview.jsp"); 
        processRequest(request, response);
    }

    private void sendMessage() throws ServletException, IOException {
        
        
        sender = request.getParameter("sender");
        recipient = request.getParameter("recipient");
        title = request.getParameter("title");
        content = request.getParameter("content");
        sendDate = new Date();
        
        Message message = new Message(messageID, sender, recipient, title, content, sendDate);
        messageDao = (MessageDao)session.getAttribute("messageDao");
        messageDao.sendMessage(sender, recipient, title, content, sendDate);
        
        System.out.print("message has been sent successfully");  
        response.sendRedirect("messageview.jsp");
       
    }

    private void editMessage() {
    }

    private void deleteMessage() {
    }

}
