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
 * @author Griffin
 */
public class FeedbackController {
    private FeedbackDao feedbackDao;
    private SimpleDateFormat yearDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    
    public FeedbackController(HttpSession session) {
        feedbackDao = (FeedbackDao)session.getAttribute("feedbackDao");
    }
    
    public Feedback[] getFeedbacks(ObjectId refCommentId, int commentId, String commSubject, String comment, Date commDate, boolean escalated, String sort, int order) {
        return feedbackDao.getFeedback(refCommentId, commentId, commSubject, comment, commDate, escalated, sort, order);
    }
    
    public boolean addFeedback(Feedback feedback) {
        return feedbackDao.addFeedback(feedback);
    }
    
    public boolean deleteFeedback(ObjectId refCommentId) {
        return feedbackDao.deleteJob(refCommentId);
    }
}
