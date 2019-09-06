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
    
    public DB getDatabase() {
        return database;
    }
    
    public Attendance[] getAttendance() {
        DBCursor cursor = collection.find();
        System.out.println("COUNT: " + cursor.count());
        Attendance[] attendances = new Attendance[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId refStudentId = (ObjectId)result.get("refStudentId");
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
            attendances[count] = new Attendance(refStudentId, studentId, firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId);
            count ++;
        }
        return attendances;
    }
    
    //grabs the attendance record of a student according to their refStudentId
    public Attendance getSingleAttendance (ObjectId refStudentId){
        BasicDBObject query = new BasicDBObject();
        query.put("_id", refStudentId);
        DBCursor cursor = collection.find(query);
        DBObject result = cursor.one();
        if (result != null) {
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
            return new Attendance(refStudentId, studentId, firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId);

        }
        return null;
    }
    
    public Attendance getClassAttendance (String tutId){
        BasicDBObject query = new BasicDBObject();
        query.put("tutorialId", tutId);
        DBCursor cursor = collection.find(query);
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId refStudentId = (ObjectId)result.get("refStudentId");
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
            return new Attendance(refStudentId, studentId, firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId);

        }
        return null;
    }
    
    public void editAttendance(Attendance attendance) {
        BasicDBObject query = new BasicDBObject().append("_id", attendance.getRefStudentId());
        BasicDBObject records = new BasicDBObject();
        BasicDBObject update = new BasicDBObject();
        if (attendance.getWk1() != null) records.append("wk1", user.getWk1());