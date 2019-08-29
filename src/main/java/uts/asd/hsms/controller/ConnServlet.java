package uts.asd.hsms.controller;

import com.mongodb.MongoClient;
import uts.asd.hsms.model.dao.MongoDBConnector;
import uts.asd.hsms.model.dao.*;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ConnServlet extends HttpServlet {
    private MongoDBConnector mongoDbConnector;  
    private UserDao userDao;
    private TutorialDao tutorialDao;
    private MongoClient mongoClient;
    private boolean dbStatus;
     
    @Override //Create and instance of DBConnector for the deployment session
    public void init() {
        try {
            mongoDbConnector = new MongoDBConnector();
            mongoClient = mongoDbConnector.openConnection();
        } catch (UnknownHostException ex) {
            Logger.getLogger(ConnServlet.class.getName()).log(Level.SEVERE, null, ex);
        }    
    }
    
    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        userDao = new UserDao(mongoClient);        
        session.setAttribute("userDao", userDao);
        
        tutorialDao = new TutorialDao(mongoClient);
        session.setAttribute("tutorialDao", tutorialDao);
        
    }
    
    @Override //Destroy the servlet and release the resources of the application
     public void destroy() {
         mongoDbConnector.closeConnection();
    }
  
}
