/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Andrew
 */

import java.io.Serializable;
import java.util.Date;
import javax.validation.constraints.FutureOrPresent;
import javax.validation.constraints.PastOrPresent;
import org.bson.types.ObjectId;
import javax.validation.constraints.Pattern;
import uts.asd.hsms.controller.validator.*;

public class Feed implements Serializable {
    private ObjectId feedId;
    private int newsId;
    @Pattern(regexp = "^.{1,50}$", message = "<h5 class=\"alert-heading\">Title Error</h5><hr>"
        + "Cannot be blank<br>"
        + "No more than 50 Characters<hr>", groups = ValidatorGroupA.class)
    
    private String title;
    @Pattern(regexp = "^[.\\s\\S]{1,2000}$", message = "<h5 class=\"alert-heading\">Description Error</h5><hr>"
        + "Cannot be blank<br>"
        + "No more than 2000 Characters<hr>", groups = ValidatorGroupB.class)
    private String body;
  //  private String workType;
    private String department;
   // private String status;
    @PastOrPresent(message = "<h5 class=\"alert-heading\">Post Date Error</h5><hr>"
            + "Must be present or in the past", groups = ValidatorGroupC.class)
    private Date postDate;
  //  @FutureOrPresent(message = "<h5 class=\"alert-heading\">Close Date Error</h5><hr>"
  //          + "Must be in the future unless in Draft mode or Closed", groups = ValidatorGroupD.class)
  //  private Date closeDate;
  //  private Boolean active;

    public Feed(ObjectId feedId,int newsId, String title, String body, String department, Date postDate) {
        this.feedId = feedId;
         this.newsId = newsId;
        this.title = title;
        this.body = body;
        this.department = department;
        this.postDate = postDate;
  
    }

    public ObjectId getFeedId() {
        return feedId;
    }

    public void setFeedId(ObjectId feedId) {
        this.feedId = feedId;
    }

    
    
        public int getNewsId() {
        return newsId;
    }
    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public int getNewNewsId() {
        return newsId + 1;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String  body) {
        this.body = body;
    }

    

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

   

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }
    
   

    
}
