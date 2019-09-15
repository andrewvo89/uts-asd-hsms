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
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.dao.JobApplicationDao;
import uts.asd.hsms.model.dao.JobDao;

/**
 *
 * @author Andrew
 */

public class JobBoardController {
    private JobApplicationDao jobApplicationDao;
    private JobDao jobDao;
    private SimpleDateFormat longDate = new SimpleDateFormat("d MMMM"); 
    
    public JobBoardController(HttpSession session) {
        jobApplicationDao = (JobApplicationDao)session.getAttribute("jobApplicationDao");
        jobDao = (JobDao)session.getAttribute("jobDao");
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
    public String getButtonLabel(ObjectId jobId, ObjectId userId) {
        String buttonLabel = "";
        //Find match in job applications with jobid and userid as the parameters
        JobApplication[] jobApplicationSearch = getJobApplications(null, jobId, userId, null, null, null, "status", 1);
        if (jobApplicationSearch.length == 1) {//if there is a result found (can only be 1 result or none)
            String status = jobApplicationSearch[0].getStatus();
            Date statusDate = jobApplicationSearch[0].getStatusDate();
            buttonLabel = status;            
            if (!status.contains("Review")) buttonLabel += " on " + longDate.format(statusDate);            
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
    //Change button color depending on status of application
    public String getButtonColor(String buttonLabel) {
        if (buttonLabel.contains("Apply")) return "primary";
        else if (buttonLabel.contains("Applied")) return "secondary";
        else if (buttonLabel.contains("Under Review")) return "warning";
        else if (buttonLabel.contains("Rejected")) return "danger";
        else if (buttonLabel.contains("Successful")) return "success";
        return "primary";
    }
    //Disable button if job has already been applied for
    public String getButtonDisabled(String buttonLabel) {
        if (!buttonLabel.contains("Apply")) return "disabled";
        return "";
    }
    public String getFooterLabel(Date postDate) {
        long difference = new Date().getTime() - postDate.getTime();
        int days = (int)(difference / (1000*60*60*24));
        if (days != 1) return days + " days ago";
        return days + " day ago";
    }
    //Talk to Dao to get all jobs
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate, String sort, int order) {
        return jobDao.getJobs(jobId, title, description, workType, department, status, postDate, closeDate, sort, order);
    }
    //Talk to Dao to get all job applications
    public JobApplication[] getJobApplications(ObjectId jobApplicationId, ObjectId jobId, ObjectId userId, String coverLetter, String status, Date statusDate, String sortBy, int orderBy) {
        return jobApplicationDao.getJobApplications(jobApplicationId, jobId, userId, coverLetter, status, statusDate, sortBy, orderBy);
    }
    
}
