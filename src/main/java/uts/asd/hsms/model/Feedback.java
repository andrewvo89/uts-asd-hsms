/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import java.io.Serializable;
import java.util.Date;
import org.bson.types.ObjectId;
import javax.validation.constraints.*;
/**
 *
 * @author Griffin
 */
public class Feedback implements Serializable{
    
    private ObjectId refCommentId;
    private int commentId;
    private String commSubject;
    private String comment;
    private Date commDate;
    private Boolean escalated;
    private Boolean archived;
    
    public Feedback (ObjectId refCommentId, int commentId, String commSubject, String comment, Date commDate, Boolean escalated, Boolean archived) {
        this.refCommentId = refCommentId;
        this.commentId = commentId;
        this.commSubject = commSubject;
        this.comment = comment;
        this.commDate = commDate;
        this.escalated = escalated;
        this.archived = archived;
    }
    
    public ObjectId getRefCommentId() {
        return refCommentId;
    }
    public void setRefCommentId(ObjectId refCommentId) {
        this.refCommentId = refCommentId;
    }
    
    public int getCommentId() {
        return commentId;
    }
    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }
    public int getNewCommentId() {
        return commentId + 1;
    }
    
    public String getCommSubject() {
        return commSubject;
    }
    public void setCommSubject(String commSubject) {
        this.commSubject = commSubject;
    }
    
    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public Date getCommDate() {
        return commDate;
    }
    public void setCommDate(Date commDate) {
        this.commDate = commDate;
    }
    
    public Boolean getEscalated() {
        return escalated;
    }
    public void setEscalated (Boolean escalated) {
        this.escalated = escalated;
    }
    
    public Boolean getArchived() {
        return archived;
    }
    public void setArchived (Boolean archived) {
        this.archived = archived;
    }
    
    public String getEscalatedString() {
        if (escalated) return "Yes";
        else return "No";
    }
    
}
