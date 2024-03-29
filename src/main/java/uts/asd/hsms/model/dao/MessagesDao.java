    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import java.util.Arrays;
import java.util.Date;

import org.bson.types.ObjectId;
import uts.asd.hsms.model.Message;

/**
 *
 * @author Sukonrat
 */
public class MessagesDao {
    MongoClient mongoClient;
    DB database;
    DBCollection collection; 
    
    public MessagesDao (MongoClient mongoClient){
        
        this.mongoClient = mongoClient;        
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("messages");     
    }
    
    public DB getDatabase() {
        return database;
    }
    
    // get single message by its id
    public Message getSingleMessage(ObjectId messageID){
        
       BasicDBObject query = new BasicDBObject();
            query.put("_id", messageID);
            DBCursor cursor = collection.find(query);
            DBObject result = cursor.one();
            if (result != null) {
            String senderResult = (String)result.get("sender");
            String recipientResult = (String)result.get("recipient");
            String contentResult = (String)result.get("content");
            Date dateResult = (Date)result.get("date");
            
            return new Message(messageID, senderResult, recipientResult, contentResult, dateResult); 
            }
    return null;
    
    }
    
    // get all messages of particular user
    public Message[] getMessage(String name){
        
         BasicDBObject query = new BasicDBObject();
         query.put("recipient", name);
            DBCursor cursor = collection.find(query);
            cursor.sort(new BasicDBObject("date", 1));
            Message[] messages = new Message[cursor.count()];
            int count = 0;
      
           while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId messageID = (ObjectId)result.get("_id");
            String sender = (String)result.get("sender");
            String recipient = (String)result.get("recipient");
            String content = (String)result.get("content");
            Date date = (Date)result.get("date");
            messages[count] = new Message(messageID, sender, recipient, content, date);
            count++;
           }
            
        return messages;

    }
    // get all messages
    public Message[] getMessages(ObjectId messageID, String sender, String recipient, String content, Date date){
  
            DBCursor cursor = collection.find();
            cursor.sort(new BasicDBObject("date", 1));
            Message[] messages = new Message[cursor.count()];
        int count = 0;
       
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId messageIDResult = (ObjectId)result.get("_id");
            String senderResult = (String)result.get("sender");
            String recipientResult = (String)result.get("recipient");
            String contentResult = (String)result.get("content");
            Date dateResult = (Date)result.get("date");
            messages[count] = new Message(messageIDResult, senderResult, recipientResult, contentResult, dateResult);
            count++;
        }
        Arrays.sort(messages, 0, 1);
        return messages;
   
    }

    public boolean sendMessage(String name, String recipient, String content, Date date){
        try{
            BasicDBObject records = new BasicDBObject();
            records.append("sender", name).append("recipient", recipient).append("content", content).append("date", date);
            collection.insert(records);
            
        }
       catch (Exception ex) {
            return false;
        }
        return true; 
    }
    
    public boolean deleteMessage(ObjectId messageID){
        try{
            BasicDBObject query = new BasicDBObject();
            query.put("_id", messageID);
            collection.remove(query);
        }
        catch (Exception ex) {
            return false;
        }
        return true; 
    }
    
    public boolean forwardMessage(String name, String recipient, String content, Date date){
        try{
            BasicDBObject records = new BasicDBObject();
            records.append("sender", name).append("recipient", recipient).append("content", content).append("date", date);
            collection.insert(records);
        }
        catch (Exception ex) {
            return false;
        }
        return true; 
    }
    
}
