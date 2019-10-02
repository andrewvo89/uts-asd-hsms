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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import static java.util.regex.Pattern.CASE_INSENSITIVE;
import static java.util.regex.Pattern.compile;
import static java.util.regex.Pattern.quote;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Calendar;

/**
 *
 * @author MatthewHellmich
 */
public class CalendarDao {

    private MongoClient mongoClient;
    private DB database;
    private DBCollection collection;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public CalendarDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("calendar");
    }

    public DB getDatabase() {
        return database;
    }

    public Calendar[] getCalendar() {
        DBCursor cursor = collection.find();
        Calendar[] calendars = new Calendar[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId calendarIdResult = (ObjectId) result.get("_id");
            Date dateResult = (Date) result.get("loginTime");
            String eventNameResult = (String) result.get("eventName");
            String descriptionResult = (String) result.get("description");
            String eventTagResult = (String) result.get("eventTag");
            calendars[count] = new Calendar(null, dateResult, eventNameResult, descriptionResult, eventTagResult);
            count++;

        }
        return calendars;
    }

//    public Calendar[] getCalendars(ObjectId calendarId, Date date, String eventName, String description, String eventTag) {
//        List<BasicDBObject> conditions = new ArrayList<>();
//        BasicDBObject query = new BasicDBObject();
//        DBCursor cursor;
//        
//        if (calendarId != null) {
//            conditions.add(new BasicDBObject("_id", calendarId));
//        }
//        if (date != null) {
//            if (!date.toString().isEmpty()) conditions.add(new BasicDBObject("date", compile(quote(dateFormat.format(date)), CASE_INSENSITIVE)));
//        }
//        if (eventName != null) {
//            if (!eventName.isEmpty()) conditions.add(new BasicDBObject("eventName", compile(quote(eventName), CASE_INSENSITIVE)));
//        }
//        if (description != null) {
//            if (!description.isEmpty()) conditions.add(new BasicDBObject("description", compile(quote(description), CASE_INSENSITIVE)));
//        }
//        
//        if (eventTag != null) {
//            if (!eventTag.isEmpty()) conditions.add(new BasicDBObject("eventTag", compile(quote(eventTag), CASE_INSENSITIVE)));
//        }
//        
//        if (conditions.size() == 0) {
//            cursor = collection.find();            
//        }
//        else {
//            query.put("$and", conditions);
//            cursor = collection.find(query);
//        }    
//        
//        cursor.sort(new BasicDBObject("date", 1));
//        Calendar[] calendars = new Calendar[cursor.count()];
//
//        int count = 0;
//        while (cursor.hasNext()) {
//            DBObject result = cursor.next();
//            ObjectId calendarIdResult = (ObjectId)result.get("_id");
//            Date dateResult = (Date)result.get("date");
//            String eventNameResult = (String)result.get("eventName");
//            String descriptionResult = (String)result.get("description");
//            String eventTagResult = (String)result.get("eventTag");
//            calendars[count] = new Calendar(calendarIdResult, dateResult, eventNameResult, descriptionResult, eventTagResult);
//            count++;
//        }
//        return calendars;
//    }
    public void addcalendar(Date date, String eventName, String description, String eventTag) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
