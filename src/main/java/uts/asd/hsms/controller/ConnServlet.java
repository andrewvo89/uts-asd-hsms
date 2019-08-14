package uts.asd.hsms.controller;

import com.mongodb.MongoClient;
import uts.asd.hsms.model.dao.MongoDBConnector;
import uts.asd.hsms.model.dao.*;
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

public class ConnServlet extends HttpServlet {
    private MongoDBConnector mongoConnector;  
    private UserDao userDao;
    private String dbUser, dbPass; 
    private MongoClient mongoClient;
     
    @Override //Create and instance of DBConnector for the deployment session
    public void init() {
        try {
            mongoConnector = new MongoDBConnector(); 
        } catch (UnknownHostException ex) {
            Logger.getLogger(ConnServlet.class.getName()).log(Level.SEVERE, null, ex);
        }    
    }
  
    
    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
        response.setContentType("text/html;charset=UTF-8");  
        HttpSession session = request.getSession();
        
        mongoClient = mongoConnector.openConnection();
        userDao = new UserDao(mongoClient);

        session.setAttribute("userDao", userDao);
    }    
  
}
