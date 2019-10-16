/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.dao.*;
import uts.asd.hsms.model.*;
import java.util.Date;

/**
 *
 * @author Griffin
 */
public class FeedbackServlet extends HttpServlet {
    private HttpSession session;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private FeedbackController controller;
    //private FeedbackDao feedbackDao;
    private ObjectId refCommentId;
    private int commentId;
    private String commSubject, comment;
    private Boolean escalated, archived;
    private Date commDate;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();
        controller = new FeedbackController(session);
        //feedbackDao = (FeedbackDao)session.getAttribute("feedbackDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;
        
        String action = request.getParameter("action");
        switch (action) {
            case "add":
                addFeedback();
                break;
            case "archive":
                archiveFeedback();
                break;
            case "delete":
                deleteFeedback();
                break;
            default:
                response.sendRedirect("complaintbacklog.jsp");
               break;       
        }
    }
    
     public void addFeedback() throws ServletException, IOException {
        Feedback lastFeedback = controller.getFeedback(null, 0, null, null, null, null, null, "commentId", -1)[0];
        commentId = lastFeedback.getNewCommentId();
        commSubject = request.getParameter("commSubjectAdd").trim();
        comment = request.getParameter("commentAdd").trim();
        commDate = new Date();
        
        Feedback feedback = new Feedback(null, commentId, commSubject, comment, commDate, false, false);
        //add your validation code
        controller.addFeedback(feedback);
        
        response.sendRedirect("complaintfill.jsp");
    }
     
    public void archiveFeedback() throws ServletException, IOException {
        Feedback oldFeedback = null, newFeedback = null;
        refCommentId = new ObjectId(request.getParameter("postRefCommentId"));
        commentId = Integer.parseInt(request.getParameter("postCommentId"));
        commSubject = request.getParameter("postCommSubject").trim();
        comment = request.getParameter("postComment").trim();
        commDate = null;
        escalated = false;
        archived = true;
        String editModalErrorMessage = "";
        Boolean editSuccess = false;
        message.add("Archive Feedback Result");
        
        if (controller.getFeedback(refCommentId, 0, null, null, null, null, null, "commentId", 1).length != 0) {
            oldFeedback = controller.getFeedback(refCommentId, 0, null, null, null, null, null, "commentId", 1)[0];
            newFeedback = new Feedback(refCommentId, commentId, commSubject, comment, commDate, escalated, archived);
            
            controller.archiveFeedback(newFeedback);
            response.sendRedirect("complaintbacklog.jsp");
        } else editModalErrorMessage = "Failed to archive feedback: no such feedback exists.";
    }
    
    public void deleteFeedback() throws ServletException, IOException {
        refCommentId = new ObjectId(request.getParameter("refCommentIdDelete"));
        boolean deleteSuccess = false;
        message.add("Delete comment result"); //If the Feedback exists in database based on refCommentId
        if (controller.getFeedback(refCommentId, 0, null, null, null, null, null, "commentId", 1)[0] != null){
            Feedback feedback = controller.getFeedback(refCommentId, 0, null, null, null, null, null, "commentId", 1)[0];
            if (controller.deleteFeedback(refCommentId)) message.add(String.format("%s deleted successfully", feedback.getCommentId())); message.add("success"); deleteSuccess = true;
        }
        response.sendRedirect("complaintbacklog.jsp");
    } 
}
