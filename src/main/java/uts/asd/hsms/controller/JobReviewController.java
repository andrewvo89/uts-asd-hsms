/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import com.mongodb.BasicDBObject;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
    //Get status string and date based on the records inside the DBObject
    public ArrayList getCurrentStatusStringDate(BasicDBObject status) {
        ArrayList<Object> statusStringDate = new ArrayList<>();
        if (((Date) status.get("successful")).getTime() != 0) {
            statusStringDate.add("Successful");
            statusStringDate.add((Date) status.get("successful"));
        } else if (((Date) status.get("rejected")).getTime() != 0) {
            statusStringDate.add("Rejected");
            statusStringDate.add((Date) status.get("rejected"));
        } else if (((Date) status.get("review")).getTime() != 0) {
            statusStringDate.add("Under Review");
            statusStringDate.add((Date) status.get("review"));
        } else {
            statusStringDate.add("Applied");
            statusStringDate.add((Date) status.get("applied"));
        }
        return statusStringDate;
    }
    //Change buttons ability to submit a form depending on its status
    public String[] getStatusButtonToggle(BasicDBObject status) {
        String currentStatusString = (String) getCurrentStatusStringDate(status).get(0);
        String[] statusButtonType = new String[4];
        //Make all submit buttons
        for (int x = 0; x < statusButtonType.length; x ++) statusButtonType[x] = "modal";
        //Disable submit for the Applied button
        statusButtonType[0] = "";
        if (currentStatusString.equals("Under Review")) statusButtonType[1] = "";
        if (currentStatusString.equals("Rejected")) statusButtonType[2] = "";
        if (currentStatusString.equals("Successful")) statusButtonType[3] = "";
        return statusButtonType;
    }
    //Change button to outline if it does not have a date on it
    public String[] getStatusOutline(BasicDBObject status) {
        String[] statusButtonLabel = new String[4];
        for (int x = 0; x < statusButtonLabel.length; x ++) statusButtonLabel[x] = "";
        if (((Date) status.get("applied")).getTime() == 0) statusButtonLabel[0] = "-outline";
        if (((Date) status.get("review")).getTime() == 0) statusButtonLabel[1] = "-outline";
        if (((Date) status.get("rejected")).getTime() == 0) statusButtonLabel[2] = "-outline";
        if (((Date) status.get("successful")).getTime() == 0) statusButtonLabel[3] = "-outline";
        return statusButtonLabel;
    }
    //Get status button text depending on status
    public String[] getStatusButtonLabel(BasicDBObject status) {
        String[] statusButtonLabel = new String[4];
        statusButtonLabel[0] = "Applied";
        statusButtonLabel[1] = "Acknowledge Application";
        statusButtonLabel[2] = "Reject Applicant";
        statusButtonLabel[3] = "Successful Applicant"; 
        if (((Date) status.get("applied")).getTime() != 0) statusButtonLabel[0] = "Applied on " + longDate.format((Date) status.get("applied"));
        if (((Date) status.get("review")).getTime() != 0) statusButtonLabel[1] = "Under Review on " + longDate.format((Date) status.get("review"));
        if (((Date) status.get("rejected")).getTime() != 0) statusButtonLabel[2] = "Rejected on " + longDate.format((Date) status.get("rejected"));
        if (((Date) status.get("successful")).getTime() != 0) statusButtonLabel[3] = "Successful on " + longDate.format((Date) status.get("successful"));
        return statusButtonLabel;
    }    
    //Get how many days since last action
    public String getFooterLabel(String statusString, Date statusDate) {
        long difference = new Date().getTime() - statusDate.getTime();
        int days = (int)(difference / (1000*60*60*24));
        if (days == 0) return "Last Activity: " + statusString + " today";
        else if (days == 1) return "Last Activity: " + statusString + " yesterday";
        else return "Last Activity: " + statusString + " " + days + " days ago";
    }
    //Process line breaks in cover letter for HTML displaying
    public String processLineBreaks(String coverLetter) {
        coverLetter = coverLetter.replaceAll("\n", "<br>");
        return coverLetter;
    }
    //Talk to Dao to get all jobs
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate, Boolean active, String sort, int order) {
        return jobDao.getJobs(jobId, title, description, workType, department, status, postDate, closeDate, active, sort, order);
    }
    public boolean editJob(Job job) {
        return jobDao.editJob(job);
    }
    //Talk to Dao to get all job applications
    public JobApplication[] getJobApplications(ObjectId jobApplicationId, ObjectId jobId, ObjectId userId, String coverLetter, BasicDBObject status, String sortBy, int orderBy) {
        return jobApplicationDao.getJobApplications(jobApplicationId, jobId, userId, coverLetter, status, sortBy, orderBy);
    }
    //Edit job application
    public boolean editJobApplication(JobApplication jobApplication) {
        return jobApplicationDao.editJobApplication(jobApplication);
    }
    //Talk to Dao to get all job applications
    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, Boolean active, String sort, int order) {
        return userDao.getUsers(userId, firstName, lastName, phone, location, email, password, department, userRole, active, sort, order);
    }
}
