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
import org.bson.types.ObjectId;
import javax.validation.constraints.Pattern;

public class Job implements Serializable {
    private ObjectId jobId;
    private String title;
    private String description;
    private String workType;
    private String department;
    private String status;
    private Date postDate;
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
