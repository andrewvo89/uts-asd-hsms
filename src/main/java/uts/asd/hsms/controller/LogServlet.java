/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import com.mongodb.MongoClient;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;

import uts.asd.hsms.model.UserAudit;
import uts.asd.hsms.model.dao.AuditLogDAO;

/**
 *
 * @author Sukonrat
 */
public class LogServlet extends HttpServlet {
    
private HttpSession session;
    private AuditLogDao auditLogDao;
    private ArrayList<String> logList;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId userId;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         
        
     /*   String userID = request.getParameter("userID");	
        String date = request.getParameter("date");
        
        UserAudit userAudit = new UserAudit();
        AuditLogDAO dao = new AuditLogDAO();
        userAudit.setUserID(userID);
        userAudit.setTimeStamp(date);
        
        request.setAttribute("userAudit",userAudit); 
         UserAudit[] userAudits = dao.getUserAudit();
         request.setAttribute("userAudit",userAudits); 
         
       RequestDispatcher dispatcher = request.getRequestDispatcher("log.jsp");
        
        dispatcher.forward(request,response);
        
     //   HttpSession session = request.getSession(true);
    //    String session_counter = (String)session.getAttribute("counter");
    //    out.println("login" + DateFormat.getDateTimeInstance().format(new Date(session.getMaxInactiveInterval()))); */
   
    }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
 session = request.getSession();
        auditLogDao = (AuditLogDao)session.getAttribute("auditLogDao");
        logList = new ArrayList<String>();
        this.response = response;
        this.request = request;
        RequestDispatcher dispatcher = request.getRequestDispatcher("log.jsp");
        dispatcher.forward(request,response);
     // doGet(request, response);
   }

    private static class AuditLogDao {

        public AuditLogDao() {
        }
    }
}
        