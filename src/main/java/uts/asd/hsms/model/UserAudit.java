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

    public static String getFirstName;  
    private ObjectId logID;
    private String firstName;
    private Date loginTime;
   
    public UserAudit(ObjectId logID, String firstName, Date loginTime){
        this.logID = logID;
        this.firstName = firstName;
        this.loginTime = loginTime;
        
    }

    public UserAudit() {
       
    }
    public void setLogID(ObjectId logID){
    this.logID = logID;
    }
    
    public ObjectId getLogID(){
    return logID;
    }
   
    public void setFirstName(String firstName){
    this.firstName = firstName;
    }
     public String getFirstName(){
    return firstName;
    }
   
    public void setLoginTime(Date loginTime){
    this.loginTime = loginTime;
    }
 
    public Date getLoginTime(){
    return loginTime;
    
    }
 
}
