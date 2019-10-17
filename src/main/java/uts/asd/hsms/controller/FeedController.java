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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Feed;
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.JobApplicationDao;
import uts.asd.hsms.model.dao.FeedDao;
import uts.asd.hsms.model.dao.UserDao;

/**
 *
 * @author Alvin
 */

public class FeedController {
    private JobApplicationDao jobApplicationDao;
    private FeedDao feedDao;
    private UserDao userDao;
    private SimpleDateFormat longDate = new SimpleDateFormat("d MMMM"); 
    
    public FeedController(HttpSession session) {
      //  feedApplicationDao = (FeedApplicationDao)session.getAttribute("jobApplicationDao");
        feedDao = (FeedDao)session.getAttribute("feedDao");
        userDao = (UserDao)session.getAttribute("userDao");
    }

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

    public String getFooterLabel(Date postDate) {
        long difference = new Date().getTime() - postDate.getTime();
        int days = (int)(difference / (1000*60*60*24));
        if (days == 0) return "Today";
        else if (days == 1) return "Yesterday";
        else return days + " days ago";
    }
    
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
    
   /*
    public Feed[] getFeeds(ObjectId feedId, int newsId, String title, String body,  String department,Date postDate) {
        return feedDao.getFeeds(feedId, newsId, title, body, department, postDate);
    } 
    */
    
    
    public LinkedList<DBObject> getFeeds(){
        return feedDao.getFeeds();
    }
    
    

    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, Boolean active, String sort, int order) {
        return userDao.getUsers(userId, firstName, lastName, phone, location, email, password, department, userRole, active, sort, order);
    }
        public boolean addFeed(Feed feed) {
        return feedDao.addFeed(feed);
    }
    
    public boolean editFeed(ObjectId oldId,Feed newFeed) {
        return feedDao.editFeed(oldId,newFeed);
    }
    
    public boolean deleteFeed(ObjectId objId) {
        return feedDao.deleteFeed(objId);
    }
    
    
}
