/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

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

public class Job implements Serializable {
    private ObjectId jobId;
    @Pattern(regexp = "^.{1,50}$", message = "<h5 class=\"alert-heading\">Title Error</h5><hr>"
        + "Cannot be blank<br>"
        + "No more than 50 Characters<hr>", groups = ValidatorGroupA.class)
    private String title;
    @Pattern(regexp = "^.{1,500}$", message = "<h5 class=\"alert-heading\">Description Error</h5><hr>"
        + "Cannot be blank<br>"
        + "No more than 500 Characters<hr>", groups = ValidatorGroupB.class)
    private String description;
    private String workType;
    private String department;
    private String status;
    @PastOrPresent(message = "<h5 class=\"alert-heading\">Post Date Error</h5><hr>"
            + "Must be present or in the past", groups = ValidatorGroupC.class)
    private Date postDate;
    @FutureOrPresent(message = "<h5 class=\"alert-heading\">Close Date Error</h5><hr>"
            + "Must be in the future unless in Draft mode or Closed", groups = ValidatorGroupD.class)
    private Date closeDate;

    public Job(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate) {
        this.jobId = jobId;
        this.title = title;
        this.description = description;
        this.workType = workType;
        this.department = department;
        this.status = status;
        this.postDate = postDate;
        this.closeDate = closeDate;
    }

    public ObjectId getJobId() {
        return jobId;
    }

    public void setJobId(ObjectId jobId) {
        this.jobId = jobId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPostDate() {
        return postDate;
    }

    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }
    
    public Date getCloseDate() {
        return closeDate;
    }

    public void setCloseDate(Date closeDate) {
        this.closeDate = closeDate;
    }
    
}
