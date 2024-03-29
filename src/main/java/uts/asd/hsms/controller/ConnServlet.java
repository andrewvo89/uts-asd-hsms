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
    private MongoClient mongoClient;
    private UserDao userDao;
    private JobDao jobDao;
    private FeedDao feedDao;
    private JobApplicationDao jobApplicationDao;
    private TutorialDao tutorialDao;
    private AttendanceDao attendanceDao;
    private AuditLogDAO auditLogDao;
    private FeedbackDao feedbackDao;
    private CalendarDao calendarDao;
    private MessagesDao messagesDao;
   
    
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
        jobDao = new JobDao(mongoClient);        
        session.setAttribute("jobDao", jobDao);
        
        feedDao = new FeedDao(mongoClient);
         session.setAttribute("feedDao", feedDao);
                
        jobApplicationDao = new JobApplicationDao(mongoClient);
        session.setAttribute("jobApplicationDao", jobApplicationDao);
        tutorialDao = new TutorialDao(mongoClient);
        session.setAttribute("tutorialDao", tutorialDao);        
        attendanceDao = new AttendanceDao(mongoClient);
        session.setAttribute("attendanceDao", attendanceDao);
        auditLogDao = new AuditLogDAO(mongoClient);
        session.setAttribute("auditLogDao", auditLogDao);
        feedbackDao = new FeedbackDao(mongoClient);
        session.setAttribute("feedbackDao", feedbackDao);
        calendarDao = new CalendarDao(mongoClient);
        session.setAttribute("calendarDao", calendarDao);        
        messagesDao = new MessagesDao(mongoClient);
        session.setAttribute("messageDao", messagesDao);
       
    }
    
    @Override //Destroy the servlet and release the resources of the application
     public void destroy() {
         mongoClient.close();
         mongoDbConnector.closeConnection();
    }
  
}
