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
import java.util.List;
import static java.util.regex.Pattern.CASE_INSENSITIVE;
import static java.util.regex.Pattern.compile;
import static java.util.regex.Pattern.quote;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.*;

/**
 *
 * @author Andrew
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
    
    
    public Feed[] getFeeds(ObjectId feedId, int newsId, String title, String body,  String department,Date postDate, String sort, int order) {  
        List<BasicDBObject> conditions = new ArrayList<>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor;//If the parameter fields are NULL, do not include them in query
        if (feedId != null) {
            conditions.add(new BasicDBObject("_id", feedId));
        }
        if (newsId != 0) {
            conditions.add(new BasicDBObject("newsId", newsId));
        }
        if (title != null) {
            if (!title.isEmpty()) conditions.add(new BasicDBObject("title", compile(quote(title), CASE_INSENSITIVE)));
        }
        if (body != null) {
            if (!body.isEmpty()) conditions.add(new BasicDBObject("body", compile(quote(body), CASE_INSENSITIVE)));
        }
       
        if (department != null) {
            if (!department.isEmpty()) {
                if (!department.equals("All")) conditions.add(new BasicDBObject("department", compile(quote(department), CASE_INSENSITIVE)));
            }
        }
        
        if (postDate != null) {
            if (!postDate.toString().isEmpty()) conditions.add(new BasicDBObject("postdate", compile(quote(dateFormat.format(postDate)), CASE_INSENSITIVE)));
        }
       
        if (conditions.size() == 0) {
            cursor = collection.find();            
        }
        else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }    
        cursor.sort(new BasicDBObject(sort, order));
        Feed[] feeds = new Feed[cursor.count()];//Initialize a User array, the size of the results returned

        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId feedIdResult = (ObjectId)result.get("_id");
            int newsIdResult = (int)result.get("newsId");
            String titleResult = (String)result.get("title");
            String bodyResult = (String)result.get("body");
           // String workTypeResult = (String)result.get("worktype");
            String departmentResult = (String)result.get("department");
          //  String statusResult = (String)result.get("status");
            Date postDateResult = (Date)result.get("postdate");
          //  Date closeDateResult = (Date)result.get("closedate");
          //  Boolean activeResult = (Boolean)result.get("active");
            feeds[count] = new Feed(feedIdResult,newsIdResult, titleResult, bodyResult, departmentResult, postDateResult);
            count ++;
        }
        return feeds;
    }
    
    public boolean addFeed(Feed feed) {//Simple add to Mongo Database
        try {
            BasicDBObject newRecord = new BasicDBObject();
            newRecord.put("newsId", feed.getNewsId());
            newRecord.put("title", feed.getTitle());
            newRecord.put("description", feed.getBody());
         //  newRecord.put("worktype", job.getWorkType());
            newRecord.put("department", feed.getDepartment());
         //   newRecord.put("status", job.getStatus());
            newRecord.put("postdate", new Date());
          //  newRecord.put("closedate", job.getCloseDate());
        //    newRecord.put("active", true);
            collection.insert(newRecord);  
            feed.setFeedId((ObjectId)newRecord.get("_id"));
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }  
        public boolean editFeed(Feed feed) { //Edit job in database based on _id
        try {
            BasicDBObject query = new BasicDBObject().append("_id", feed.getFeedId());
            BasicDBObject records = new BasicDBObject();
            BasicDBObject update = new BasicDBObject();
            if (feed.getNewsId() != 0) records.append("newsId", feed.getNewsId());
            if (feed.getTitle() != null) records.append("title", feed.getTitle());
            if (feed.getBody() != null) records.append("body", feed.getBody());
          //  if (job.getWorkType() != null) records.append("worktype", job.getWorkType());
            if (feed.getDepartment() != null) records.append("department", feed.getDepartment());
           // if (feed.getStatus() != null) records.append("status", job.getStatus());
          //  if (feed.getCloseDate() != null) records.append("closedate", job.getCloseDate());
          //  if (feed.getActive() != null) records.append("active", job.getActive());
            update.append("$set", records);
            collection.update(query, update);
            feed.setFeedId((ObjectId)query.get("_id"));
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    } 
    
    public boolean deleteFeed(Feed feed) { //Make Job inactive, DO NOT DELTE so no references are lost
        try {
            BasicDBObject query = new BasicDBObject().append("_id", feed.getFeedId());
            BasicDBObject records = new BasicDBObject();
         //   records.append("active", false);
          //  records.append("status", "Closed");
            BasicDBObject update = new BasicDBObject().append("$set", records);
            collection.update(query, update);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }
}
