/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uts.asd.hsms.model.UserAudit;
import uts.asd.hsms.model.dao.AuditLogDAO;

/**
 *
 * @author Sukonrat
 */
public class LogManagementServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     AuditLogDAO dao = new AuditLogDAO();
     UserAudit[] logList = dao.getUserAudit();  
    RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("logmanagement.jsp");
    request.setAttribute("userAudit",logList);
    dispatcher.forward(request, response);
      
    } 
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
 
      doGet(request, response);
   }  
    
}
        