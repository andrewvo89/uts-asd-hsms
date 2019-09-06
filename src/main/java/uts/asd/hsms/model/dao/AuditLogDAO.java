/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;
import static com.google.appengine.repackaged.org.joda.time.format.ISODateTimeFormat.date;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCursor;


import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.bson.Document;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.UserAudit;

/**
 *
 * @author sukonrat
 */
public class AuditLogDAO {

    MongoClient mongoClient;
    DB database;
    DBCollection collection; 
    
    public AuditLogDAO(MongoClient mongoClient, DBObject[] logList) {
        this.mongoClient = mongoClient;        
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("logs");  
    }

    public AuditLogDAO() {
       
    }

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
    
    public void addLoginTime(ObjectId userId,String timeStamp) {
        BasicDBObject records = new BasicDBObject();
        records.append("userId", userId).append("date", timeStamp);
        collection.insert(records);
    }  

   
}
