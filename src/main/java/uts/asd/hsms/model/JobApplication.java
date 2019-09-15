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
import uts.asd.hsms.controller.validator.*;

public class JobApplication implements Serializable {
    private ObjectId jobApplicationId;
    private ObjectId jobId;
    private ObjectId userId;
    @Pattern(regexp = "^.{1,2000}$", message = "<h5 class=\"alert-heading\">Cover Letter Error</h5><hr>"
    + "Cannot be blank<br>"
    + "No more than 2000 Characters<hr>", groups = ValidatorGroupA.class)
    private String coverLetter;
    private String status;
    private Date statusDate;

    public JobApplication(ObjectId jobApplicationId, ObjectId jobId, ObjectId userId, String coverLetter, String status, Date statusDate) {
        this.jobApplicationId = jobApplicationId;
        this.jobId = jobId;
        this.userId = userId;
        this.coverLetter = coverLetter;
        this.status = status;
        this.statusDate = statusDate;
    }

    public ObjectId getJobApplicationId() {
        return jobApplicationId;
    }

    public void setJobApplicationId(ObjectId jobApplicationId) {
        this.jobApplicationId = jobApplicationId;
    }

    public ObjectId getJobId() {
        return jobId;
    }

    public void setJobId(ObjectId jobId) {
        this.jobId = jobId;
    }

    public ObjectId getUserId() {
        return userId;
    }

    public void setUserId(ObjectId userId) {
        this.userId = userId;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getStatusDate() {
        return statusDate;
    }

    public void setStatusDate(Date statusDate) {
        this.statusDate = statusDate;
    }
    
}
