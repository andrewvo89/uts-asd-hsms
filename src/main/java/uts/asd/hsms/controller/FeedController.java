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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
 * @author Andrew
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
   
    public Feed[] getFeeds(ObjectId feedId, int newsId, String title, String body,  String department,Date postDate, String sort, int order) {
        return feedDao.getFeeds(feedId, newsId, title, body, department, postDate, sort, order);
    }

    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, Boolean active, String sort, int order) {
        return userDao.getUsers(userId, firstName, lastName, phone, location, email, password, department, userRole, active, sort, order);
    }
    
}
