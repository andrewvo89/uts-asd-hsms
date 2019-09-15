/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.*;
import uts.asd.hsms.model.dao.*;

/**
 *
 * @author Andrew
 */
public class JobReviewController {
    private JobApplicationDao jobApplicationDao;
    private JobDao jobDao;
    private UserDao userDao;
    private SimpleDateFormat longDate = new SimpleDateFormat("d MMMM"); 
    
    public JobReviewController(HttpSession session) {
        jobApplicationDao = (JobApplicationDao)session.getAttribute("jobApplicationDao");
        jobDao = (JobDao)session.getAttribute("jobDao");
        userDao = (UserDao)session.getAttribute("userDao");
    }
    //Get status button states depending on status
    public String[] getStatusButtonDisabled(String status) {
        String[] statusButtonDisabled = new String[4];
        for (int x = 0; x < statusButtonDisabled.length; x ++) statusButtonDisabled[x] = "";
        statusButtonDisabled[0] = "disabled";
        if (status.equals("Under Review")) statusButtonDisabled[1] = "disabled";  
        if (status.equals("Rejected") || status.equals("Successful")) { statusButtonDisabled[1] = "disabled"; statusButtonDisabled[2] = "disabled"; statusButtonDisabled[3] = "disabled"; }
        return statusButtonDisabled;
    }
    //Get status button text depending on status
    public String[] getStatusButtonLabel(String status, Date statusDate) {
        String[] statusButtonLabel = new String[4];
        statusButtonLabel[0] = "Applied";
        statusButtonLabel[1] = "Review Application";
        statusButtonLabel[2] = "Reject Applicant";
        statusButtonLabel[3] = "Successful Applicant"; 
        if (status.equals("Applied")) statusButtonLabel[0] = "Applied on " + longDate.format(statusDate);
        if (status.equals("Under Review")) statusButtonLabel[1] = "Under Review on " + longDate.format(statusDate);
        if (status.equals("Rejected")) statusButtonLabel[2] = "Rejected on " + longDate.format(statusDate);
        if (status.equals("Successful")) statusButtonLabel[3] = "Successful on " + longDate.format(statusDate);
        return statusButtonLabel;
    }
    //Talk to Dao to get all jobs
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate, String sort, int order) {
        return jobDao.getJobs(jobId, title, description, workType, department, status, postDate, closeDate, sort, order);
    }
    //Talk to Dao to get all job applications
    public JobApplication[] getJobApplications(ObjectId jobApplicationId, ObjectId jobId, ObjectId userId, String coverLetter, String status, Date statusDate, String sortBy, int orderBy) {
        return jobApplicationDao.getJobApplications(jobApplicationId, jobId, userId, coverLetter, status, statusDate, sortBy, orderBy);
    }
    //Talk to Dao to get all job applications
    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, String sort, int order) {
        return userDao.getUsers(userId, firstName, lastName, phone, location, email, password, department, userRole, sort, order);
    }
}
