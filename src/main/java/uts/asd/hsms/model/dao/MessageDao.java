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
import java.util.Date;
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
    
    public MessageDao(MongoClient mongoClient){
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
            ObjectId messageIDResult = (ObjectId)result.get("_id");
            String senderResult = (String)result.get("sender");
            String recipientResult = (String)result.get("recipient");
            String titleResult = (String)result.get("title");
            String contentResult = (String)result.get("content");
           Date dateResult = (Date)result.get("createDate");
            messages[count] = new Message(messageIDResult, senderResult, recipientResult, titleResult, contentResult, dateResult);
            count ++;
        }
        System.out.print(messages);
        return messages;
    
    }
    
    
    public void sendMessage(String sender, String recipient, String title, String content, Date createDate){
        
        BasicDBObject records = new BasicDBObject();
        records.append("sender", sender).append("recipient", recipient).append("title", title).append("content", content).append("createDate", createDate);
        collection.insert(records);
    }
    
    public void deleteMessage(){
    
    }
    
    public void editMessage(){
    
    }
}
