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
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.User;

/**
 *
 * @author Andrew
 */
public class JobReviewServlet extends HttpServlet {
    private ObjectId jobAppliationId, jobId, userId;
    private BasicDBObject status;
    private JobReviewController controller;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private JobApplication jobApplication;
    private Job job;
    private User user;
    private HttpSession session;
    private ArrayList<String> message;
    private Date zeroDate = new Date();
    private EmailNotifier emailNotifier;
    private String statusEmail;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
    }    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.response = response;
        this.request = request;    
        session = request.getSession();
        message = new ArrayList<>();
        controller = new JobReviewController(session);
        String action = request.getParameter("action");
        statusEmail = ""; 
        jobAppliationId = new ObjectId(request.getParameter("jobApplicationId"));
        zeroDate.setTime(0);
        message.add("Status Change Result");
        jobApplication = null;
        Boolean editSucess = false;
        emailNotifier = new EmailNotifier();
        
        if (controller.getJobApplications(jobAppliationId, null, null, null, null, "jobid", 1).length != 0) {//If exists in database
            jobApplication = controller.getJobApplications(jobAppliationId, null, null, null, null, "jobid", 1)[0];
            jobId = jobApplication.getJobId();
            userId = jobApplication.getUserId();
            status = jobApplication.getStatus();
            job = controller.getJobs(jobId, null, null, null, null, null, null, null, "_id", 1)[0];
            user = controller.getUsers(userId, null, null, null, null, null, null, null, 0, "_id", 1)[0];
            //Depending on which button got pressed on the previous page
            switch (action) {
                case "review":
                    reviewJobApplication();
                    break;
                case "reject":
                    rejectJobApplication();
                    break;
                case "success":
                    successfulJobApplication();
                    break;
                default:
                    break;
            }
            jobApplication.setStatus(status);        
            if (controller.editJobApplication(jobApplication)) editSucess = true;
        }        
        if (editSucess) {
            try {
                sendEmail(user.getFirstName(), job.getTitle(), statusEmail);
                message.add(String.format("%s's Job Application has now been updated. A notification email has been sent to %s", user.getFirstName(), user.getEmail()));
            } catch (MessagingException ex) {
                message.add(String.format("%s's Job Application has now been updated. A notification email has <b>failed</b> to be sent to %s", user.getFirstName(), user.getEmail()));
            }
            message.add("success");
        }
        else {
            message.add(String.format("Status update failed"));
            message.add("danger");
        }
        session.setAttribute("message", message);
        response.sendRedirect("jobreview.jsp?jobId=" + jobId.toString());
    }
    
    public void reviewJobApplication() throws ServletException, IOException {
        //All following step's dates should be changed back to 0
        status.put("review", new Date()); status.put("rejected", zeroDate); status.put("successful", zeroDate);
        statusEmail = "Under Review";
    }
    public void rejectJobApplication() throws ServletException, IOException {
        //Success date should be changed back to 0
        status.put("rejected", new Date()); status.put("successful", zeroDate);
        statusEmail = "Rejected";
    }
    public void successfulJobApplication()throws ServletException, IOException {
        //Write current sucess date to current date
        status.put("successful", new Date()); 
        statusEmail = "Successful";
        //Write rejected status to today on all other applicants & write success on any other applicant to 0
        JobApplication[] jobApplications = controller.getJobApplications(null, jobId, null, null, null, "_id", 1);
        for (JobApplication rejecetedJobApplication : jobApplications) {
            if (!rejecetedJobApplication.getUserId().equals(userId)) {
                //Get rejected User
                User rejectedUser = controller.getUsers(rejecetedJobApplication.getUserId(), null, null, null, null, null, null, null, 0, "_id", 1)[0];
                //Edit all other users that's not current user in question
                BasicDBObject tempStatus = rejecetedJobApplication.getStatus();
                tempStatus.put("rejected", new Date());
                tempStatus.put("successful", zeroDate);
                rejecetedJobApplication.setStatus(tempStatus);
                controller.editJobApplication(rejecetedJobApplication);
                try {
                    //Send rejected email to all other applicants
                    sendEmail(rejectedUser.getFirstName(), job.getTitle(), "Rejected");
                } catch (MessagingException ex) {
                    Logger.getLogger(JobReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        //Set status of the job to Closed, so it is not displayed on the Job Board anymore
        job.setStatus("Closed");
        controller.editJob(job);
    }
    public void sendEmail(String firstName, String jobTitle, String jobApplicationStatus) throws MessagingException {
        emailNotifier.sendEmail("uts.asd.hsms@gmail.com", "Job Application: " + jobTitle, String.format("Dear %s,\n\n"
        + "Your job application for the %s role has been updated to: %s.\n"
        + "To check your current Job Application's status, visit https://uts-asd-hsms.herokuapp.com/jobboard.jsp\n\n"              
        + "Kind Regards,\nThe HSMS Team", firstName, jobTitle, jobApplicationStatus));
    }
}
