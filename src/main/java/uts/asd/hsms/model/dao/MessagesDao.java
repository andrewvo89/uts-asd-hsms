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
import uts.asd.hsms.model.User;

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
             String sender = (String)result.get("sender");
            String recipient = (String)result.get("recipient");
            String title = (String)result.get("title");
            String content = (String)result.get("content");
            Date date = (Date)result.get("date");  
            
               return new Message(messageID, sender, recipient, title, content, date); 
            }
    return null;
    
    }
    
    // get all messages of particular user
    public Message[] getMessage(String email){
         BasicDBObject query = new BasicDBObject();
            query.put("recipient", email);
            DBCursor cursor = collection.find(query);
            cursor.sort(new BasicDBObject("date", 1));
            Message[] messages = new Message[cursor.count()];
            int count = 0;
        //    DBObject result = cursor.one();
           // if (result != null) {
           while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId messageID = (ObjectId)result.get("messageID");
            String sender = (String)result.get("sender");
            String recipient = (String)result.get("recipient");
            String title = (String)result.get("title");
            String content = (String)result.get("content");
            Date date = (Date)result.get("date");
            messages[count] = new Message(messageID, sender, recipient, title, content, date);
            count++;
           }
            
    return messages;

    }
    // get all messages
    public Message[] getMessages(){
  
     DBCursor cursor = collection.find();
      // System.out.println("COUNT: " + cursor.count());
      cursor.sort(new BasicDBObject("date", 1));
      //         Staff[] staff = new Staff[cursor.count()];
         Message[] messages = new Message[cursor.count()];
        int count = 0;
       
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId messageID = (ObjectId)result.get("_id");
            String sender = (String)result.get("sender");
            String recipient = (String)result.get("recipient");
            String title = (String)result.get("title");
            String content = (String)result.get("content");
            Date date = (Date)result.get("date");
            messages[count] = new Message(messageID, sender, recipient, title, content, date);
            count++;
        }
//        System.out.print(messages);
        Arrays.sort(messages, 0, 1);
        return messages;
   
    }

    public void sendMessage(String sender, String recipient, String title, String content, Date date){
        
        BasicDBObject records = new BasicDBObject();
        records.append("sender", sender).append("recipient", recipient).append("title", title).append("content", content).append("date", date);
        collection.insert(records);
    }
    
    public void deleteMessage(ObjectId messageID){
        BasicDBObject query = new BasicDBObject();
            query.put("_id", messageID);
            collection.remove(query);
    }
    
    public void forwardMessage(ObjectId messageID, String sender, String recipient, String title, String content, Date date){
     /*   BasicDBObject query = new BasicDBObject().append("_id", message.getMessageID());
            BasicDBObject records = new BasicDBObject();
            BasicDBObject update = new BasicDBObject();
            if(message.getRecipient() != null) records.append("recipient", message.getRecipient());
            if(message.getSender() != null) records.append("sender", message.getSender());
            if(message.getTitle() != null) records.append("title", message.getTitle());
            if(message.getContent() != null) records.append("content", message.getContent());
            update.append("$set", records);
            collection.update(query, update);
    */
      BasicDBObject query = new BasicDBObject();
        query.put("_id", messageID);
        BasicDBObject newRecord = new BasicDBObject(); 
     newRecord.append("sender", sender).append("recipient", recipient).append("title", title).append("content", content).append("date", date);

        collection.update(query, newRecord);        
    }
    
}
