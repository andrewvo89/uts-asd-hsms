package uts.asd.hsms.controller;

import uts.asd.hsms.model.dao.MongoDBConnector;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author George
 */
public class ConnServlet extends HttpServlet {
    private MongoDBConnector connector;  
     
    @Override 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String adminuser = request.getParameter("admin");
        String adminpass = request.getParameter("Admin1234");
        connector = new MongoDBConnector(adminuser, adminpass);        
        response.setContentType("text/html;charset=UTF-8");  
        HttpSession session = request.getSession();              
        String status = (connector != null) ? "Connected to mLab" : "Disconnected from mLab";        
        
        session.setAttribute("status", status); 
        session.setAttribute("adminuser", adminuser);
        session.setAttribute("adminpassword", adminpass);
          
        RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
        rs.forward(request, response);
        
    }    
  
}
