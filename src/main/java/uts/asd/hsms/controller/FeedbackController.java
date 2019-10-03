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
 * @author Griffin
 */
public class FeedbackController {
    private FeedbackDao feedbackDao;
    private SimpleDateFormat dayDateFormat = new SimpleDateFormat("dd-MM-yyyy");
    
    public FeedbackController(HttpSession session) {
        feedbackDao = (FeedbackDao)session.getAttribute("feedbackDao");
    }
    
    public Feedback[] getFeedback(ObjectId refCommentId, int commentId, String commSubject, String comment, Date commDate, String escalated, String archived, String sort, int order) {
        return feedbackDao.getFeedback(refCommentId, commentId, commSubject, comment, commDate, escalated, archived, sort, order);
    }
    
    public boolean addFeedback(Feedback feedback) {
        return feedbackDao.addFeedback(feedback);
    }
    
    public boolean deleteFeedback(ObjectId refCommentId) {
        return feedbackDao.deleteJob(refCommentId);
    }
    
}
