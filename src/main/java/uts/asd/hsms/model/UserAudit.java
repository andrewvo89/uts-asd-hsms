/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;
import java.io.Serializable;
import java.security.Timestamp;
import java.util.Date;
import org.bson.types.ObjectId;

/**
 *
 * @author sukonrat
 */
public class UserAudit implements Serializable{

    public static ObjectId getUserID;
    private ObjectId userID;
    private String firstName;
    private String timeStamp;
   
    public UserAudit(ObjectId userID, String firstName, String timeStamp){
        this.userID = userID;
        this.firstName = firstName;
        this.timeStamp = timeStamp;
        
    }

    public UserAudit() {
       
    }
    
    public void setUserID(ObjectId userID){
    this.userID = userID;
    }
    
    public ObjectId getUserID(){
    return userID;
    }
    
    public void setFirstName(String firstName){
    this.firstName = firstName;
    }
     public String getFirstName(){
    return firstName;
    }
   
    public void setTimeStamp(String timeStamp){
    this.timeStamp = timeStamp;
    }
 
    public String getTimeStamp(){
    return timeStamp;
    
    }

    public void setUserID(String userID) {
       
    }
 
}
