package uts.asd.hsms.controller;

import uts.asd.hsms.model.dao.MongoDBConnector;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    private String adminemail, adminpassword;
    private UserDao userDao;
    
    //Create and instance of DBConnector for the deployment session
    @Override 
    public void init() {
        adminemail = "heroku_r0hsk6vb";
        adminpassword = "gr128qe2kcsdjbgkhbj0r5ng4p";
        try {
            System.out.println("HELLO1");
            connector = new MongoDBConnector(adminemail, adminpassword);
        }
        catch (UnknownHostException ex) {
            Logger.getLogger(ConnServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
     
    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("HELLO2");
        //String adminemail = request.getParameter("adminemail");
        //String adminpass = request.getParameter("adminpassword");
        String adminemail = "heroku_r0hsk6vb";
        String adminpass = "gr128qe2kcsdjbgkhbj0r5ng4p";
        connector = new MongoDBConnector(adminemail, adminpass);
        response.setContentType("text/html;charset=UTF-8");  
        HttpSession session = request.getSession();              
        String status = (connector != null) ? "Connected to mLab" : "Disconnected from mLab";        

        session.setAttribute("status", status); 
        session.setAttribute("adminemail", adminemail);
        session.setAttribute("adminpassword", adminpass);
          
        RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
        rs.forward(request, response);
    }    
   
    @Override 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("HELLO2");
        //String adminemail = request.getParameter("adminemail");
        //String adminpass = request.getParameter("adminpassword");
        String adminemail = "heroku_r0hsk6vb";
        String adminpass = "gr128qe2kcsdjbgkhbj0r5ng4p";
        connector = new MongoDBConnector(adminemail, adminpass);
        response.setContentType("text/html;charset=UTF-8");  
        HttpSession session = request.getSession();              
        String status = (connector != null) ? "Connected to mLab" : "Disconnected from mLab";        

        session.setAttribute("status", status); 
        session.setAttribute("adminemail", adminemail);
        session.setAttribute("adminpassword", adminpass);
          
        RequestDispatcher rs = request.getRequestDispatcher("index.jsp");
        rs.forward(request, response);
    }    
}
