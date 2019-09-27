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
import java.util.ArrayList;
import static java.util.Arrays.sort;
import java.util.List;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Message;

/**
 *
 * @author Sukonrat
 */
public class MessageDao {
    MongoClient mongoClient;
    DB database;
    DBCollection collection; 
    
    public MessageDao (MongoClient mongoClient){
        
        this.mongoClient = mongoClient;        
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("messages");     
    }
    
    public DB getDatabase() {
        return database;
    }
    
    public Message[] getMessage(){
  
      DBCursor cursor = collection.find();
     System.out.println("COUNT: " + cursor.count());      
       Message[] messages = new Message[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId messageID = (ObjectId)result.get("_id");
            String sender = (String)result.get("sender");
            String recipient = (String)result.get("recipient");
            String title = (String)result.get("title");
            String content = (String)result.get("content");
         
            messages[count] = new Message(messageID, sender, recipient, title, content);
            count ++;
        }
        System.out.print(messages);
        return messages;
   
    }
    
    
    public void sendMessage(String sender, String recipient, String title, String content){
        
        BasicDBObject records = new BasicDBObject();
        records.append("sender", sender).append("recipient", recipient).append("title", title).append("content", content);
        collection.insert(records);
    }
    
    public void deleteMessage(){
    
    }
    
    public void editMessage(){
    
    }   
}
