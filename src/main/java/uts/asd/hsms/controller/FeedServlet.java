/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.controller.validator.JobApplicationValidator;
import uts.asd.hsms.controller.validator.UserValidator;
import uts.asd.hsms.model.Feed;
import uts.asd.hsms.model.Feedback;
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.User;

/**
 *
 * @author Andrew
 */
public class FeedServlet extends HttpServlet {
    //  private JobApplication jobApplication;
    //  private Feed feed;

    private User user;
    private FeedController controller;
    private ObjectId feedId, userId;
    private int newsId;
    private String title, body, department;
    private Date postDate;
    private BasicDBObject status;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private ArrayList<String> message;
    //  private JobApplicationValidator jobApplicationValidator;
    private EmailNotifier emailNotifier;
    private LinkedList<DBObject> feeds;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.response = response;
        this.request = request;
        session = request.getSession();
        message = new ArrayList<String>();
        controller = new FeedController(session);
        emailNotifier = new EmailNotifier();
        System.out.println("Test userid:"+userId);
         System.out.println("Test feedId:"+feedId);
     //  userId = new ObjectId(request.getParameter("userId"));
      // feedId = new ObjectId(request.getParameter("feedId"));
        feeds = controller.getFeeds();
        //    Feed = controller.getFeeds(feedId,0, null, null, null, null, "_id", 1)[0];
        user = controller.getUsers(userId, null, null, null, null, null, null, null, 0, null, "_id", 1)[0];
        String action = request.getParameter("action");
        switch (action) {
            case "add":
                addFeed();
                break;
            case "edit":
                editFeed();
                break;
            case "delete":
                deleteFeed();
                break;
            default:
                response.sendRedirect("newsfeed.jsp");
                break;
        }

    }

    public void addFeed() throws ServletException, IOException {
    //    LinkedList<DBObject> Feed = controller.getFeeds();
        title = request.getParameter("titleAdd").trim();
        body = request.getParameter("bodyAdd").trim();
        department = request.getParameter("departmentAdd").trim();
        postDate = new Date();
        System.out.println(title);
        System.out.println(postDate);

        Feed feed = new Feed(null, 0, title, body, department, postDate);
        
     //   DBObject feedObj = ;
        
        //add your validation code
        controller.addFeed(feed);
        response.sendRedirect("newsfeed.jsp");
    }

    public void editFeed() throws ServletException, IOException {
 
        Feed oldFeed = null, newFeed = null;
        feedId = new ObjectId(request.getParameter("feedIdEdit"));  
        title = request.getParameter("titleEdit").trim();
        body = request.getParameter("bodyEdit").trim();
        department = request.getParameter("departmentEdit").trim();
        postDate = Calendar.getInstance().getTime();
        
        System.out.println("edit date:"+postDate.toString());
       
        String editModalErrorMessage = "";
        Boolean editSuccess = false;
     // 、、  Filters.e
        message.add("Edit Feed Result");

        //if (controller.getFeeds(feedId, 0, null, null, null, null, "newsId", 1).length != 0) {
        //  oldFeed = controller.getFeeds(feedId, 0, null, null, null, null, "newsId", 1)[0];
        Date tmp = new Date();
        
        newFeed = new Feed(feedId, newsId, title, body, department, tmp);
        
        newFeed.setPostDate(postDate);
        
     //    DBObject newfeedObj = ;
       // feeds.add(newFeed);//???
        
          controller.editFeed(feedId,newFeed);
        //       response.sendRedirect("newsfeed.jsp");
        //  } else editModalErrorMessage = "Failed to edit feed: no such feed exists.";
        response.sendRedirect("newsfeed.jsp");
    }
    
    
    public void deleteFeed() throws ServletException, IOException {
        
        feedId = new ObjectId(request.getParameter("feedIdDelete"));
        
         System.out.println("Deleting Feed..."+feedId);
         
     //      DBObject feedObj = ;
     //      controller.
        
        boolean deleteSuccess = false;
        message.add("Delete Post result"); //If the Feedback exists in database based on refCommentId
        if (feeds.size() != 0) {
            //  Feed feed = controller.getFeeds(feedId,0, null, null, null, null, "_id", 1)[0];
            if (controller.deleteFeed(feedId)) {
                message.add(String.format("%s deleted successfully", feedId));
            }
            message.add("success");
            deleteSuccess = true; 
            
            response.sendRedirect("newsfeed.jsp");
        }
       
    }

}
