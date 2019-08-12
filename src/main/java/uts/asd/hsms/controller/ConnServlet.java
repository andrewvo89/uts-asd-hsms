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
<<<<<<< HEAD
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
=======
    private MongoDBConnector connector;  
>>>>>>> parent of e8564ce... Merge branch 'andrew' of https://github.com/andrewvo89/uts-asd-hsms into andrew
     
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
