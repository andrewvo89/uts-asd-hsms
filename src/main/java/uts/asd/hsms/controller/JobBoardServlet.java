/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.controller.validator.JobApplicationValidator;
import uts.asd.hsms.controller.validator.JobValidator;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.dao.JobApplicationDao;
/**
 *
 * @author Andrew
 */
public class JobBoardServlet extends HttpServlet {
    private JobApplicationDao jobApplicationDao;
    private ObjectId jobApplicationId, jobId, userId;
    private String coverLetter, status;
    private Date statusDate;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private ArrayList<String> message;
    private JobApplicationValidator jobApplicationValidator;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {    
        this.response = response;
        this.request = request;    
        session = request.getSession();
        jobApplicationDao = (JobApplicationDao)session.getAttribute("jobApplicationDao");
        message = new ArrayList<String>();
        applyJob();
    }
    
    public void applyJob() throws ServletException, IOException {
        userId = new ObjectId(request.getParameter("userId"));
        jobId = new ObjectId(request.getParameter("jobId"));
        coverLetter = request.getParameter("coverLetter").trim();
        status = "Applied";
        statusDate = new Date();
        //Job Application to be added into the Database
        JobApplication jobApplication = new JobApplication(null, jobId, userId, coverLetter, status, statusDate);        
        jobApplicationValidator = new JobApplicationValidator(jobApplication);//Server Side validations
        String[] errorMessages = jobApplicationValidator.validateJobApplication();//If Server Side validations have errors
        message.add("Add User Result");        
        //If Errors from validation
        if (errorMessages != null) {
            message.add(errorMessages[0]); message.add("danger");
        }
        else {
            if (jobApplicationDao.addJobApplication(jobApplication)) { message.add("Your Job Application has been received successfully"); message.add("success"); }//If Add Success
            else message.add("Failed to add Job: Database issue"); message.add("danger");//If Add Failed 
        }
        session.setAttribute("message", message);
        response.sendRedirect("jobboard.jsp");
    }
}
