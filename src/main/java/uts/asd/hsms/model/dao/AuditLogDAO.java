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
import java.util.Date;
import java.util.List;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.UserAudit;

/**
 *
 * @author sukonrat
 */
public class AuditLogDAO {

    MongoClient mongoClient;
    DB database;
    DBCollection collection; 
    
    public AuditLogDAO(MongoClient mongoClient) {
        this.mongoClient = mongoClient;        
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("logs");  
    }
    
    public DB getDatabase() {
        return database;
    }
    // get single userlog
public UserAudit[] getUserAudit() { 
        DBCursor cursor = collection.find();
        cursor.sort(new BasicDBObject(("logId"), 1));
        UserAudit[] userAudits = new UserAudit[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId logId = (ObjectId)result.get("_id");
            ObjectId userId = (ObjectId)result.get("userID");
            String firstName = (String)result.get("firstName");
            Date loginTime = (Date)result.get("date");
            userAudits[count] = new UserAudit(logId, firstName, loginTime);
            count ++;
        }
        return userAudits; 
    }
    
    // get all userlogs
    public UserAudit[] getAllUserAudit(ObjectId logId, String firstName, Date loginTime){
       List<BasicDBObject> conditions = new ArrayList<>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor;
       
        if (logId != null){
       conditions.add(new BasicDBObject("_id", logId));
        }
        if (firstName != null) {
            if (!firstName.isEmpty()) conditions.add(new BasicDBObject("firstname", firstName));
        }
        if(loginTime != null){
             conditions.add(new BasicDBObject("loginTime", loginTime));
        }
        if (conditions.size() == 0) {
            cursor = collection.find();            
        }
        else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }    
         //  cursor.sort(new BasicDBObject(sort, order));
           UserAudit[] userAudits = new UserAudit[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId logIdResult = (ObjectId)result.get("_id");
            String firstNameResult = (String)result.get("firstname");
            Date dateResult = (Date)result.get("loginTime");
            userAudits[count] = new UserAudit(logIdResult, firstNameResult, dateResult);
            count ++;
        }
        return userAudits; 
    }
    
    // get userlogs by date  
    public UserAudit[] searchByDate(String loginTime){
         DBCursor cursor = collection.find();
            BasicDBObject query = new BasicDBObject();
         UserAudit[] userAudits = new UserAudit[cursor.count()];
             query.put("loginTime", loginTime);
              DBObject result = cursor.one();
              
             if (result != null){
             ObjectId logId = (ObjectId)result.get("_id");
            ObjectId userId = (ObjectId)result.get("userID");
            String firstName = (String)result.get("firstName");
            
       return userAudits;
             }
             return null;
    }
    
    // add timestamp of user login 

    public void addLoginTime(String firstName, Date loginTime) {
         BasicDBObject records = new BasicDBObject();
        records.append("firstName", firstName).append("loginTime", loginTime);
        collection.insert(records);
    }
   
  
    
}

