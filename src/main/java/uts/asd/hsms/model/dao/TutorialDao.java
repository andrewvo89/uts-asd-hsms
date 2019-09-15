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
import uts.asd.hsms.model.*;
import com.mongodb.MongoClient;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static java.util.regex.Pattern.*;
import org.bson.Document;
import org.bson.types.ObjectId;

/**
/**
 *
 * @author Griffin
 */
public class TutorialDao {
    MongoClient mongoClient;
    DB database;
    DBCollection collection;
    
    public TutorialDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("classes");
    }
    
    public DB getDatabase() {
        return database;
    }
    
    public Tutorial[] getTutorials() {
        DBCursor cursor = collection.find();
        cursor.sort(new BasicDBObject(("tutorialId"), 1));
        Tutorial[] tutorials = new Tutorial[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId refId = (ObjectId)result.get("_id");
            String tutorialId = (String)result.get("tutorialId");
            String department = (String)result.get("department");
            int grade = (int)result.get("grade");
            ObjectId userId = (ObjectId)result.get("userId");
            int tutSize = (int)result.get("tutSize");
            tutorials[count] = new Tutorial(refId, tutorialId, department, grade, userId, tutSize);
            count ++;
        }
        return tutorials;
    }
    
}
