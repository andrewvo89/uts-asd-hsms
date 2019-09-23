/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
public class JobManagementController {
    private JobApplicationDao jobApplicationDao;
    private JobDao jobDao;
    private SimpleDateFormat yearDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
    
    public JobManagementController(HttpSession session) {
        jobDao = (JobDao)session.getAttribute("jobDao");
        jobApplicationDao = (JobApplicationDao)session.getAttribute("jobApplicationDao");
    }
    //Close off any jobs past its date
    public void setClosedStatus() {
        Job[] jobs = jobDao.getJobs(null, null, null, null, null, null, null, null, true, "title", 1);
        for (Job job : jobs) {
            if (job.getStatus().equals("Open")) {//If close date is in the past, set Status of entry to Closed.
                if (job.getCloseDate().before(new Date())) {
                    job.setStatus("Closed");
                    jobDao.editJob(new Job(job.getJobId(), null, null, null, null, "Closed", null, null, true));            
                }
            }
        }
    }
    public String getReviewButtonDisabled(ObjectId jobId) {
        JobApplication[] jobApplications = jobApplicationDao.getJobApplications(null, jobId, null, null, null, "jobid", 1);
        if (jobApplications.length == 0) return "disabled";
        else return "";
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
    //Pre-fill status radio buttons
    public String[] getStatusSearch(String status) {
        String[] statusSearch = new String[4];
        for (int x = 0; x < statusSearch.length; x ++) { statusSearch[x] = ""; }
        if (status == null) status = ""; statusSearch[0] = "checked";
        if (status.equals("Draft")) statusSearch[1] = "checked";
        if (status.equals("Open")) statusSearch[2] = "checked";
        if (status.equals("Closed")) statusSearch[3] = "checked";
        return statusSearch;
    }
    //Pre-fill work type radio buttons
    public String[] getWorkTypeEdit(String workType) {
        String[] workTypeEdit = new String[4];
        for (int x = 0; x < workTypeEdit.length; x ++) { workTypeEdit[x] = ""; }
        if (workType.equals("Full Time")) workTypeEdit[0] = "checked";
        if (workType.equals("Part Time")) workTypeEdit[1] = "checked";
        if (workType.equals("Casual")) workTypeEdit[2] = "checked";
        if (workType.equals("Contract")) workTypeEdit[3] = "checked";
        return workTypeEdit;
    }
    //Pre-fill department radio buttons
    public String[] getDepartmentEdit(String department) {
        String[] departmentEdit = new String[5];
        for (int x = 0; x < departmentEdit.length; x ++) { departmentEdit[x] = ""; }
        if (department.equals("Administration")) departmentEdit[0] = "checked";
        if (department.equals("English")) departmentEdit[1] = "checked";
        if (department.equals("Math")) departmentEdit[2] = "checked";
        if (department.equals("Science")) departmentEdit[3] = "checked";
        if (department.equals("Art")) departmentEdit[4] = "checked";
        return departmentEdit;
    }
    //Pre-fill status radio buttons
    public String[] getStatusEdit(String status) {
        String[] statusEdit = new String[3];
        for (int x = 0; x < statusEdit.length; x ++) { statusEdit[x] = ""; }
        if (status.equals("Draft")) statusEdit[0] = "checked";
        if (status.equals("Open")) statusEdit[1] = "checked";
        if (status.equals("Closed")) statusEdit[2] = "checked";
        return statusEdit;
    }
    public String getMonthDate() {
        Date today = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.add(Calendar.MONTH, 1);
        return yearDateFormat.format(calendar.getTime());
    }
    //Talk to Dao so that Servlet can talk to the database via the Controller
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate, Boolean active, String sort, int order) {
        return jobDao.getJobs(jobId, title, description, workType, department, status, postDate, closeDate, active, sort, order);
    }
    public boolean addJob(Job job) {
        return jobDao.addJob(job);
    }
    public boolean editJob(Job job) {
        return jobDao.editJob(job);
    }
    public boolean deleteJob(Job job) {
        return jobDao.deleteJob(job);
    }
    
}
