/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import java.io.Serializable;
import org.bson.types.ObjectId;


public class Tutorial implements Serializable{
    
    private ObjectId refId;
    private String tutorialId;
    private String department;
    private int grade;
    private ObjectId userId;
    private int tutSize;
    
    public Tutorial(ObjectId refId, String tutorialId, String department, int grade, ObjectId userId, int tutSize){
        this.refId = refId;
        this.tutorialId = tutorialId;
        this.department = department;
        this.grade = grade;
        this.userId = userId;
        this.tutSize = tutSize;
    }
    
    
    public ObjectId getRefId(){
        return refId;
    }
    public void setRefId(ObjectId refId){
        this.refId = refId;
    }
    
    public String getTutorialId(){
        return tutorialId;
    }
    
    public void setTutorialId(String tutorialId){
        this.tutorialId = tutorialId;
    }
    
    public String getDepartment(){
        return department;
    }
    
    public void setDepartment(String department){
        this.department = department;
    }
    
    public int getGrade(){
        return grade;
    }
    
    public void setGrade(int grade){
        this.grade = grade;
    }
    
    public ObjectId getTeacherId(){
        return userId;
    }
    
    public void setTeacherId(ObjectId userId){
        this.userId = userId;
    }
    
    public int getTutSize(){
        return tutSize;
    }
    
    public void setTutSize(int classSize){
        this.tutSize = classSize;
    }
    
    public String getUserIdString() {
        return userId.toString();
    }
    
    public String getRefIdString() {
        return refId.toString();
    }
}
