/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import static java.util.regex.Pattern.CASE_INSENSITIVE;
import static java.util.regex.Pattern.compile;
import static java.util.regex.Pattern.quote;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.*;
import com.google.gson.*;

/**
 *
 * @author Alvin
 */
public class FeedDao {
    private MongoClient mongoClient;
    private DB database;
    private DBCollection collection;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");


    public FeedDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("newsfeed");
    }
    
    public DB getDatabase() {
        return database;
    }
    
    public LinkedList<DBObject> getFeeds(){
        
        LinkedList<DBObject> results = new LinkedList<DBObject>();
        
         DBCursor cursor;
      
      cursor = collection.find(); // select * from collection;   
         

     while( cursor.hasNext() ){
     
         DBObject result = cursor.next();
         
         results.add(result);
            
     }
     
        
        return results;
        
    }
    
    
    public boolean addFeed(Feed feed) {//Simple add to Mongo Database

        try {
           
            BasicDBObject newRecord = new BasicDBObject();
            newRecord.put("newsId", feed.getNewsId());
            newRecord.put("title", feed.getTitle());
            newRecord.put("body", feed.getBody());
            newRecord.put("department", feed.getDepartment());
      
            newRecord.put("postdate", new Date());
        
            collection.insert(newRecord);  
       
       
            

        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }  
        public boolean editFeed(ObjectId oldFeedid , Feed newFeed) { //Edit job in database based on _id
        try {

          BasicDBObject query = new BasicDBObject().append("_id", oldFeedid);
          
            BasicDBObject records = new BasicDBObject();
            BasicDBObject update = new BasicDBObject();
            if (newFeed.getNewsId() != 0) records.append("newsId", newFeed.getNewsId());
            if (newFeed.getTitle() != null) records.append("title", newFeed.getTitle());
            if (newFeed.getBody() != null) records.append("body", newFeed.getBody());

            if (newFeed.getDepartment() != null) records.append("department", newFeed.getDepartment());
           if (newFeed.getPostDate() != null) records.append("postdate", newFeed.getPostDate());   
            collection.update(query, records);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    } 
    
 public boolean deleteFeed (ObjectId objId) {
     
     // find Feed from objID;
     
        try {
            BasicDBObject query = new BasicDBObject();
            query.put("_id", objId);
         //   results.remove(query);
            collection.remove(query);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }
}
