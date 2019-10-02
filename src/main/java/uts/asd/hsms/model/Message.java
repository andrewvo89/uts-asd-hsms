/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import java.io.Serializable;
import java.util.Date;
import org.bson.types.ObjectId;

/**
 *
 * @author Sukonrat
 */
public class Message implements Serializable{
    
    private ObjectId messageID;
    private String sender;
    private String recipient;
    private String title;
    private String content;
    private Date date;
    
    
    public Message(ObjectId messageID, String sender, String recipient, String title, String content, Date date){
        
        this.messageID=messageID;
        this.sender=sender;
        this.recipient=recipient;
        this.title=title;
        this.content=content;
        this.date=date;
    }

    
    public void setMessageID(ObjectId messageID){
        this.messageID=messageID;
    }
    
    public ObjectId getMessageID(){
        return messageID;
    }
    
    public void setSender(String sender){
        this.sender=sender;
    }
    
    public String getSender(){
        return sender;
    }
    
    public void setRecipient(String recipient){
        this.recipient=recipient;
    }
    
    public String getRecipient(){
        return recipient;
    }
    
    public void setTitle(String title){
        this.title=title;
    }
    
    public String getTitle(){
        return title;
    }
    
    public void setContent(String content){
        this.content=content;
    }
    
    public String getContent(){
        return content;
    }
    
    public void setDate(Date date){
        this.date=date;
    }
    public Date getDate(){
        return date;
    }
}
