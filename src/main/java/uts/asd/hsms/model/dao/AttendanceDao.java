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
import static java.util.regex.Pattern.*;
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
    /*
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
    } */
    
    public Attendance[] getAttendance(ObjectId refStudentId, int studentId, String firstName, String lastName, String wk1, String wk2, String wk3, String wk4, String wk5, String wk6, String wk7, String wk8, String wk9, String wk10, String tutorialId, String sort, int order) {
        List<BasicDBObject> conditions = new ArrayList<BasicDBObject>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor; //if the parameter fields are Null, don't include them in query
        if (refStudentId != null) conditions.add(new BasicDBObject("_id", refStudentId));
        if (studentId != 0) conditions.add(new BasicDBObject("studentId", studentId));
        if (firstName != null) {
            if (!firstName.isEmpty()) conditions.add(new BasicDBObject("firstName", compile(quote(firstName), CASE_INSENSITIVE)));
        }
        if (lastName != null) {
            if (!lastName.isEmpty()) conditions.add(new BasicDBObject("lastName", compile(quote(lastName), CASE_INSENSITIVE)));
        }
        if (wk1 != null) {
            if (!wk1.isEmpty()) conditions.add(new BasicDBObject("wk1", compile(quote(wk1), CASE_INSENSITIVE)));
        }
        if (wk2 != null) {
            if (!wk2.isEmpty()) conditions.add(new BasicDBObject("wk2", compile(quote(wk2), CASE_INSENSITIVE)));
        }
        if (wk3 != null) {
            if (!wk3.isEmpty()) conditions.add(new BasicDBObject("wk3", compile(quote(wk3), CASE_INSENSITIVE)));
        }
        if (wk4 != null) {
            if (!wk4.isEmpty()) conditions.add(new BasicDBObject("wk4", compile(quote(wk4), CASE_INSENSITIVE)));
        }
        if (wk5 != null) {
            if (!wk5.isEmpty()) conditions.add(new BasicDBObject("wk5", compile(quote(wk5), CASE_INSENSITIVE)));
        }
        if (wk6 != null) {
            if (!wk6.isEmpty()) conditions.add(new BasicDBObject("wk6", compile(quote(wk6), CASE_INSENSITIVE)));
        }
        if (wk7 != null) {
            if (!wk7.isEmpty()) conditions.add(new BasicDBObject("wk7", compile(quote(wk7), CASE_INSENSITIVE)));
        }
        if (wk8 != null) {
            if (!wk8.isEmpty()) conditions.add(new BasicDBObject("wk8", compile(quote(wk8), CASE_INSENSITIVE)));
        }
        if (wk9 != null) {
            if (!wk9.isEmpty()) conditions.add(new BasicDBObject("wk9", compile(quote(wk9), CASE_INSENSITIVE)));
        }
        if (wk10 != null) {
            if (!wk10.isEmpty()) conditions.add(new BasicDBObject("wk10", compile(quote(wk10), CASE_INSENSITIVE)));
        }
        if (tutorialId != null) {
            if (!tutorialId.isEmpty()) conditions.add(new BasicDBObject("tutorialId", compile(quote(tutorialId), CASE_INSENSITIVE)));
        }
        if (conditions.size() == 0) {
            cursor = collection.find();
        } else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }
        
        cursor.sort(new BasicDBObject(sort, order));
        Attendance[] attendances = new Attendance[cursor.count()];
        
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId refStudentIdResult = (ObjectId)result.get("_id");
            int studentIdResult = (int)result.get("studentId");
            String firstNameResult = (String)result.get("firstName");
            String lastNameResult = (String)result.get("lastName");
            String wk1Result = (String)result.get("wk1");
            String wk2Result = (String)result.get("wk2");
            String wk3Result = (String)result.get("wk3");
            String wk4Result = (String)result.get("wk4");
            String wk5Result = (String)result.get("wk5");
            String wk6Result = (String)result.get("wk6");
            String wk7Result = (String)result.get("wk7");
            String wk8Result = (String)result.get("wk8");
            String wk9Result = (String)result.get("wk9");
            String wk10Result = (String)result.get("wk10");
            String tutorialIdResult = (String)result.get("tutorialId");
            attendances[count] = new Attendance(refStudentIdResult, studentIdResult, firstNameResult, lastNameResult, wk1Result, wk2Result, wk3Result, wk4Result, wk5Result, wk6Result, wk7Result, wk8Result, wk9Result, wk10Result, tutorialIdResult);
            count ++;
        }
        return attendances;
    }
    
    public boolean editAttendance(Attendance attendance) {
    try {
        BasicDBObject query = new BasicDBObject().append("_id", attendance.getRefStudentId());
        BasicDBObject records = new BasicDBObject();
        BasicDBObject update = new BasicDBObject();
        if (attendance.getStudentId() != 0) records.append("studentId", attendance.getStudentId());
        if (attendance.getFirstName() != null) records.append("firstName", attendance.getFirstName());
        if (attendance.getLastName() != null) records.append("lastName", attendance.getLastName());
        if (attendance.getWk1() != null) records.append("wk1", attendance.getWk1());
        if (attendance.getWk1() != null) records.append("wk2", attendance.getWk2());
        if (attendance.getWk1() != null) records.append("wk3", attendance.getWk3());
        if (attendance.getWk1() != null) records.append("wk4", attendance.getWk4());
        if (attendance.getWk1() != null) records.append("wk5", attendance.getWk5());
        if (attendance.getWk1() != null) records.append("wk6", attendance.getWk6());
        if (attendance.getWk1() != null) records.append("wk7", attendance.getWk7());
        if (attendance.getWk1() != null) records.append("wk8", attendance.getWk8());
        if (attendance.getWk1() != null) records.append("wk9", attendance.getWk9());
        if (attendance.getWk1() != null) records.append("wk10", attendance.getWk10());
        if (attendance.getTutorialId() != null) records.append("tutorialId", attendance.getTutorialId());
        update.append("$set", records);
        collection.update(query, update);
        }
    catch (Exception ex) {
        return false;
    }
    return true;
    }
}