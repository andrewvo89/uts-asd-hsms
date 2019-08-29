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
import java.util.List;
import org.bson.types.ObjectId;

/**
/**
 *
 * @author Griffin
 */
public class AttendanceDao {
    MongoClient mongoClient;
    DB database;
    DBCollection collection;
    
    public AttendanceDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("studentattendance");
    }
    
    public Attendance[] getAttendance() {
        DBCursor cursor = collection.find();
        System.out.println("COUNT: " + cursor.count());
        Attendance[] attendances = new Attendance[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            int studentId = (int)result.get("studentId");
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String wk1 = (String)result.get("wk1");
            String wk2 = (String)result.get("wk2");
            String wk3 = (String)result.get("wk3");
            String wk4 = (String)result.get("wk4");
            String wk5 = (String)result.get("wk5");
            String wk6 = (String)result.get("wk6");
            String wk7 = (String)result.get("wk7");
            String wk8 = (String)result.get("wk8");
            String wk9 = (String)result.get("wk9");
            String wk10 = (String)result.get("wk10");
            String tutorialId = (String)result.get("tutorialId");
            attendances[count] = new Attendance(studentId, firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId);
            count ++;
        }
        return attendances;
    }
    
}