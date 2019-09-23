/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.controller.validator.JobValidator;
import uts.asd.hsms.model.Job;
/**
 *
 * @author Andrew
 */
public class JobManagementServlet extends HttpServlet {
    private JobManagementController controller;
    private ObjectId jobId;
    private String title, description, workType, department, status;
    private Date postDate, closeDate;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private ArrayList<String> message;
    private JobValidator jobValidator;
    private SimpleDateFormat yearDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
        this.response = response;
        this.request = request;    
        session = request.getSession();
        controller = new JobManagementController(session);
        message = new ArrayList<String>();
        String action = request.getParameter("action");             
        if (action.equals("add")) addJob();
        else if (action.equals("edit")) editJob();
        else if (action.equals("delete")) deleteJob();
        else response.sendRedirect("jobmanagement.jsp");
    }
    
    public void addJob() throws ServletException, IOException {
        title = request.getParameter("titleAdd").trim();
        description = request.getParameter("descriptionAdd").trim();
        workType = request.getParameter("workTypeAdd").trim();
        department = request.getParameter("departmentAdd").trim();
        status = request.getParameter("statusAdd").trim();
        postDate = new Date();
        try {
            closeDate = yearDateFormat.parse(request.getParameter("closeDateAdd"));
        }
        catch (ParseException e) {
            closeDate = new Date();
        }
        //Job to be added into the Database
        Job job = new Job(null, title, description, workType, department, status, postDate, closeDate, true);
        Date tempDate = null;
        if (job.getStatus().equals("Draft") && job.getCloseDate().before(new Date())) {
            tempDate = job.getCloseDate();//Bypass validation for Close Date if the post is already Closed or still in Draft mode
            Date tomorrowDate = new Date();
            tomorrowDate.setTime(tomorrowDate.getTime() + 86400000);
            job.setCloseDate(tomorrowDate);
        }
        jobValidator = new JobValidator(job);//Server Side validations
        String[] errorMessages = jobValidator.validateJob();//If Server Side validations have errors
        if (tempDate != null) job.setCloseDate(tempDate);//Set close date back to the past after validation
        String addModalErrorMessage = "";
        Boolean addSuccess = false;
        message.add("Add User Result"); 
        
        //If Errors
        if (errorMessages != null) { 
            addModalErrorMessage = errorMessages[0]; 
        }
        else {
            if (controller.addJob(job)) addSuccess = true;
            else addModalErrorMessage = "Failed to add Job: Database issue";
        }//Add OK
        if (addSuccess) {
            message.add(String.format("%s added successfully", title)); message.add("success"); 
            session.setAttribute("message", message);//Show search results with jobId to help indicate new record on View
            jobId = job.getJobId();
            response.sendRedirect("jobmanagement.jsp?jobIdSearch=" + jobId.toString());
        }//Error from jobValidator
        else {
            message.add(addModalErrorMessage); message.add("danger");  
            session.setAttribute("message", message);
            response.sendRedirect("jobmanagement.jsp");
        }
    }

    public void editJob() throws ServletException, IOException {        
        Job oldJob = null, newJob = null;
        jobId =  new ObjectId(request.getParameter("jobIdEdit"));
        title = request.getParameter("titleEdit").trim();
        description = request.getParameter("descriptionEdit").trim();
        workType = request.getParameter("workTypeEdit").trim();
        department = request.getParameter("departmentEdit").trim();
        status = request.getParameter("statusEdit").trim();
        try { closeDate = yearDateFormat.parse(request.getParameter("closeDateEdit")); }
        catch (ParseException e) { closeDate = new Date(); }
        postDate = null;        
        String editModalErrorMessage = "";
        Boolean editSuccess = false;
        message.add("Edit User Result");
        
         if (controller.getJobs(jobId, null, null, null, null, null, null, null, true, "closedate", 1).length != 0) {
            oldJob = controller.getJobs(jobId, null, null, null, null, null, null, null, true, "closedate", 1)[0];
            newJob = new Job(jobId, title, description, workType, department, status, postDate, closeDate, true);
            //If post is published from Draft to Open, or Re-opened from Closed to Open, set new Post Date to now
            if (!oldJob.getStatus().equals("Open") && newJob.getStatus().equals("Open")) newJob.setPostDate(new Date());
            //Going from closed to open should wipe everyone's job application's to make it a fresh Job Post
            Date tempDate = null;
            if (!newJob.getStatus().equals("Open") && newJob.getCloseDate().before(new Date())) {
                tempDate = newJob.getCloseDate();//Bypass validation for Close Date if the post is already Closed or still in Draft mode
                Date tomorrowDate = new Date();
                tomorrowDate.setTime(tomorrowDate.getTime() + 86400000);
                newJob.setCloseDate(tomorrowDate);
            }
            jobValidator = new JobValidator(newJob);//Server Side validations
            String[] errorMessages = jobValidator.validateJob();
            if (tempDate != null) newJob.setCloseDate(tempDate);//Set close date back to the past after validation
            if (errorMessages != null) editModalErrorMessage = errorMessages[0];//Errors from validation
            else {//If validation errors
                if (controller.editJob(newJob)) editSuccess = true;
                else editModalErrorMessage = "Failed to edit Job: Database issue";
            }
        }
        else editModalErrorMessage = "Failed to edit Job: Job does not exist in Database";
        //Final setting of Parameters depending on edit success of failure
        if (editSuccess) {
            message.add(String.format("%s edited successfully", newJob.getTitle())); message.add("success");
        }
        else {
            message.add(editModalErrorMessage); message.add("danger");
        }
        session.setAttribute("message", message);//Set success of failure message to display on next page
        response.sendRedirect("jobmanagement.jsp?jobIdSearch=" + jobId.toString());
    }

    public void deleteJob() throws ServletException, IOException {
        jobId =  new ObjectId(request.getParameter("jobIdDelete"));
        boolean deleteSuccess = false;
        message.add("Delete User Result");//If the Job exists in databased based on jobId
        if (controller.getJobs(jobId, null, null, null, null, null, null, null, true, "closedate", 1).length != 0) {
             Job job = controller.getJobs(jobId, null, null, null, null, null, null, null, true, "closedate", 1)[0];//If successful, set success flags
             if (controller.deleteJob(job)) message.add(String.format("%s deleted successfully", job.getTitle())); message.add("success"); deleteSuccess = true;
         }//If fail delete, set failure flags
        if (!deleteSuccess) message.add("Failed to delete user"); message.add("danger");
        session.setAttribute("message", message);
        response.sendRedirect("jobmanagement.jsp");
    }
}