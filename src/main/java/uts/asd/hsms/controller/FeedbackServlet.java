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
    private ObjectId refCommentId;
    private int commentId;
    private String commSubject, comment;
    private Date commDate;
    private boolean escalated, archived;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();
        controller = new FeedbackController(session);
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;
        
        String action = request.getParameter("action");
        switch (action) {
            case "add":
                addFeedback();
                break;
            case "delete":
                deleteFeedback();
                break;
            default:
                response.sendRedirect("index.jsp");
                break;       
        }
    }
    
    public void addFeedback() throws ServletException, IOException {
        commentId = Integer.parseInt(request.getParameter("commentId").trim());
        commSubject = request.getParameter("commSubject").trim();
        comment = request.getParameter("comment").trim();
        commDate = new Date();
        escalated = false; 
        archived = false;
        
        Feedback feedback = new Feedback(null, commentId, commSubject, comment, commDate, escalated, archived);
        //add your validation code
        controller.addFeedback(feedback);
    }
    
    public void deleteFeedback() throws ServletException, IOException {
        refCommentId = new ObjectId(request.getParameter("refCommentIdDelete"));
        boolean deleteSuccess = false;
        message.add("Delete comment result"); //If the Feedback exists in database based on refCommentId
        if (controller.getFeedbacks(refCommentId, 0, null, null, null, false, false, "commentId", 1)[0] != null){
            Feedback feedback = controller.getFeedbacks(refCommentId, 0, null, null, null, false, false, "commentId", 1)[0];
            if (controller.deleteFeedback(refCommentId)) message.add(String.format("%s deleted successfully", feedback.getCommentId())); message.add("success"); deleteSuccess = true;
        }
        response.sendRedirect("complaintbacklog.jsp");
    }
}
