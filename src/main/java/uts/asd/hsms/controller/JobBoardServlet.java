/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import com.mongodb.BasicDBObject;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.controller.validator.JobApplicationValidator;
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.User;
/**
 *
 * @author Andrew
 */
public class JobBoardServlet extends HttpServlet {
    private JobApplication jobApplication;
    private Job job;
    private User user;
    private JobBoardController controller;
    private ObjectId jobId, userId;
    private String coverLetter;
    private BasicDBObject status;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private ArrayList<String> message;
    private JobApplicationValidator jobApplicationValidator;
    private EmailNotifier emailNotifier;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
        this.response = response;
        this.request = request;    
        session = request.getSession();
        message = new ArrayList<String>();
        controller = new JobBoardController(session);
        emailNotifier = new EmailNotifier();
        userId = new ObjectId(request.getParameter("userId"));
        jobId = new ObjectId(request.getParameter("jobId"));
        coverLetter = request.getParameter("coverLetter").trim();
        job = controller.getJobs(jobId, null, null, null, null, null, null, null, true, "_id", 1)[0];
        user = controller.getUsers(userId, null, null, null, null, null, null, null, 0, null, "_id", 1)[0];
        Date zeroDate = new Date();
        zeroDate.setTime(0);
        status = new BasicDBObject();
        status.put("applied", new Date()); status.put("review", zeroDate);
        status.put("rejected", zeroDate); status.put("successful", zeroDate);
        applyJob();
    }
    
    public void applyJob() throws ServletException, IOException {
        jobApplication = new JobApplication(null, jobId, userId, coverLetter, status);        
        jobApplicationValidator = new JobApplicationValidator(jobApplication);//Server Side validations
        String[] errorMessages = jobApplicationValidator.validateJobApplication();//If Server Side validations have errors
        message.add("Job Apply Result");        
        //If Errors from validation
        if (errorMessages != null) {
            message.add(errorMessages[0]); message.add("danger");
        }
        else {//If Add Success
            if (controller.addJobApplication(jobApplication)) {
                try {//Send email to Principal to inform of someone applying for job
                    sendEmail();
                } catch (MessagingException ex) {
                    Logger.getLogger(JobBoardServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                message.add("Your Job Application has been received successfully");
                message.add("success"); 
            }
            else message.add("Failed to add Job: Database issue"); message.add("danger");//If Add Failed 
        }
        session.setAttribute("message", message);
        response.sendRedirect("jobboard.jsp");
    }
    public void sendEmail() throws MessagingException {
        //Send to Principal a notification
        emailNotifier.sendEmail("uts.asd.hsms@gmail.com", "Job Application: " + job.getTitle(), String.format("Dear Principal,\n\n"
        + "%s %s has applied for the %s role.\n"
        + "To review all Job Application's for this Job Post, visit https://uts-asd-hsms.herokuapp.com/jobreview.jsp?jobId=%s\n\n"              
        + "Kind Regards,\nThe HSMS Team", user.getFirstName(), user.getLastName(), job.getTitle(), job.getJobId()));
        //Send to Teacher who just applied for a job
        emailNotifier.sendEmail("uts.asd.hsms@gmail.com", "Job Application: " + job.getTitle(), String.format("Dear %s,\n\n"
        + "Your job application for the %s role has been recieved.\n"
        + "To check your current Job Application's status, visit https://uts-asd-hsms.herokuapp.com/jobboard.jsp\n\n"              
        + "Kind Regards,\nThe HSMS Team", user.getFirstName(), job.getTitle()));
    }
}
