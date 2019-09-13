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
    private int userRole;
    private boolean checkedRole;
    
    public AuditLogDAO(MongoClient mongoClient, DBObject[] logList) {
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
        System.out.println("COUNT: " + cursor.count());
        UserAudit[] userAudits = new UserAudit[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId logId = (ObjectId)result.get("_id");
            ObjectId userId = (ObjectId)result.get("userID");
            String firstName = (String)result.get("firstName");
            String timeStamp = (String)result.get("date");
            userAudits[count] = new UserAudit(userId, firstName, timeStamp);
            count ++;
        }
        return userAudits; 
    }
    
    // get all userlogs
    public UserAudit[] getAllUserAudit(){
       
      if(checkedRole)  {
       DBCursor cursor = collection.find();
        System.out.println("COUNT: " + cursor.count());
       UserAudit[] userAudits = new UserAudit[cursor.count()];
        BasicDBObject query = new BasicDBObject();
         DBObject result = cursor.one();
       if(result != null){
          ObjectId logId = (ObjectId)result.get("_id");
            ObjectId userId = (ObjectId)result.get("userID");
            String firstName = (String)result.get("firstName");
            String timeStamp = (String)result.get("date");
           
       return userAudits; 
       }
      else
        return null;
      }
      else
     return null;
    }
    
    // get userlogs by date  
    public UserAudit[] searchByDate(String timeStamp){
         DBCursor cursor = collection.find();
            BasicDBObject query = new BasicDBObject();
         UserAudit[] userAudits = new UserAudit[cursor.count()];
             query.put("timeStamp", timeStamp);
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
   public void addLoginTime(ObjectId userId,String timeStamp) {
        BasicDBObject records = new BasicDBObject();
        records.append("userId", userId).append("date", timeStamp);
        collection.insert(records);
    }  
   
   // checked authorized of user to access through log management 
    public boolean checkedRole(){
        if(userRole == 1){
           return true; 
        }
           return false;
    }
}

