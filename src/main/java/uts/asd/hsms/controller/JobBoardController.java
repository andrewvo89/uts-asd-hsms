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
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.JobApplicationDao;
import uts.asd.hsms.model.dao.JobDao;
import uts.asd.hsms.model.dao.UserDao;

/**
 *
 * @author Andrew
 */

public class JobBoardController {
    private JobApplicationDao jobApplicationDao;
    private JobDao jobDao;
    private UserDao userDao;
    private SimpleDateFormat longDate = new SimpleDateFormat("d MMMM"); 
    
    public JobBoardController(HttpSession session) {
        jobApplicationDao = (JobApplicationDao)session.getAttribute("jobApplicationDao");
        jobDao = (JobDao)session.getAttribute("jobDao");
        userDao = (UserDao)session.getAttribute("userDao");
    }
        //Pre-fill work type radio buttons
    public String[] getWorkTypeSearch(String workType) {
        String[] workTypeSearch = new String[5];
        for (int x = 0; x < workTypeSearch.length; x ++) { workTypeSearch[x] = ""; }
        if (workType == null) workType = ""; workTypeSearch[0] = "checked";
        if (workType.equals("Full Time")) workTypeSearch[1] = "checked";
        if (workType.equals("Part Time")) workTypeSearch[2] = "checked";
        if (workType.equals("Casual")) workTypeSearch[3] = "checked";
        if (workType.equals("Contract")) workTypeSearch[4] = "checked";
        return workTypeSearch;
    }
    //Pre-fill department radio buttons
    public String[] getDepartmentSearch(String department) {
        String[] departmentSearch = new String[6];
        for (int x = 0; x < departmentSearch.length; x ++) { departmentSearch[x] = ""; }
        if (department == null) department = ""; departmentSearch[0] = "checked";
        if (department.equals("Administration")) departmentSearch[1] = "checked";
        if (department.equals("English")) departmentSearch[2] = "checked";
        if (department.equals("Math")) departmentSearch[3] = "checked";
        if (department.equals("Science")) departmentSearch[4] = "checked";
        if (department.equals("Art")) departmentSearch[5] = "checked";
        return departmentSearch;
    }
    public Job[] getAppliedJobs(ObjectId userId) {
        JobApplication[] jobApplicationSearch = getJobApplications(null, null, userId, null, null, "jobid", 1);
        Job[] appliedJobs = new Job[jobApplicationSearch.length];//Crete array of jobs length of search above
        for (int x = 0; x < jobApplicationSearch.length; x ++) {
            appliedJobs[x] = getJobs(jobApplicationSearch[x].getJobId(), null, null, null, null, null, null, null, "title", 1)[0];
        }
        return appliedJobs;
    }
    public String getButtonLabel(ObjectId jobId, ObjectId userId) {
        String buttonLabel = "";
        //Find match in job applications with jobid and userid as the parameters
        JobApplication[] jobApplicationSearch = getJobApplications(null, jobId, userId, null, null, "jobid", 1);
        if (jobApplicationSearch.length == 1) {//if there is a result found (can only be 1 result or none)
            BasicDBObject status = jobApplicationSearch[0].getStatus();
            String statusString = (String)getStatusStringDate(status).get(0);
            Date statusDate = (Date)getStatusStringDate(status).get(1);
            buttonLabel = statusString + " on " + longDate.format(statusDate);  
        }
        else {//Job not yet applied, therefore no record in database. Search for job id and get close date
            Job[] jobSearch = getJobs(jobId, null, null, null, null, null, null, null, "title", 1);
            if (jobSearch.length == 1) {//Record found
                Date closeDate = jobSearch[0].getCloseDate();
                buttonLabel = "Apply by " + longDate.format(closeDate);
            }//Else record not found (should never be the case)
            else buttonLabel = "Apply Now";
        }
        return buttonLabel;
    }
    //Get status string and date based on the records inside the DBObject
    public ArrayList getStatusStringDate(BasicDBObject status) {
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
    //Change button color depending on status of application
    public String getButtonColor(String buttonLabel) {
        if (buttonLabel.contains("Apply")) return "primary";
        else if (buttonLabel.contains("Applied")) return "primary";
        else if (buttonLabel.contains("Under Review")) return "warning";
        else if (buttonLabel.contains("Rejected")) return "danger";
        else if (buttonLabel.contains("Success")) return "success";
        return "primary";
    }
    //Disable button if job has already been applied for
    public String getButtonDisabled(String buttonLabel) {
        if (!buttonLabel.contains("Apply")) return "disabled";
        return "";
    }
    //Get how many days since job ad was posted
    public String getFooterLabel(Date postDate) {
        long difference = new Date().getTime() - postDate.getTime();
        int days = (int)(difference / (1000*60*60*24));
        if (days == 0) return "Today";
        else if (days == 1) return "Yesterday";
        else return days + " days ago";
    }
    //Change button to outline if it does not have a date on it
    public String[] getStatusButtonOutline(BasicDBObject status) {
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
        statusButtonLabel[1] = "Under Review";
        statusButtonLabel[2] = "Rejected";
        statusButtonLabel[3] = "Successful"; 
        if (((Date) status.get("applied")).getTime() != 0) statusButtonLabel[0] = "Applied on " + longDate.format((Date) status.get("applied"));
        if (((Date) status.get("review")).getTime() != 0) statusButtonLabel[1] = "Under Review on " + longDate.format((Date) status.get("review"));
        if (((Date) status.get("rejected")).getTime() != 0) statusButtonLabel[2] = "Rejected on " + longDate.format((Date) status.get("rejected"));
        if (((Date) status.get("successful")).getTime() != 0) statusButtonLabel[3] = "Successful on " + longDate.format((Date) status.get("successful"));
        return statusButtonLabel;
    }    
    //Get how many days since last action
    public String getStatusFooterLabel(String statusString, Date statusDate) {
        long difference = new Date().getTime() - statusDate.getTime();
        int days = (int)(difference / (1000*60*60*24));
        if (days == 0) return "Last Activity: " + statusString + " today";
        else if (days == 1) return "Last Activity: " + statusString + " yesterday";
        else return "Last Activity: " + statusString + " " + days + " days ago";
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
    //Process line breaks in cover letter for HTML displaying
    public String processLineBreaks(String coverLetter) {
        coverLetter = coverLetter.replaceAll("\n", "<br>");
        return coverLetter;
    }
    //Talk to Dao to get all jobs
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate, String sort, int order) {
        return jobDao.getJobs(jobId, title, description, workType, department, status, postDate, closeDate, sort, order);
    }
    //Talk to Dao to get all job applications
    public JobApplication[] getJobApplications(ObjectId jobApplicationId, ObjectId jobId, ObjectId userId, String coverLetter, BasicDBObject status, String sortBy, int orderBy) {
        return jobApplicationDao.getJobApplications(jobApplicationId, jobId, userId, coverLetter, status, sortBy, orderBy);
    }
    public boolean addJobApplication(JobApplication jobApplication) {
        return jobApplicationDao.addJobApplication(jobApplication);
    }
    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, String sort, int order) {
        return userDao.getUsers(userId, firstName, lastName, phone, location, email, password, department, userRole, sort, order);
    }
    
}
