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
import java.text.DateFormat;
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
    private DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

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
            Date dateResult = (Date) result.get("date");
            String eventNameResult = (String) result.get("eventName");
            String descriptionResult = (String) result.get("description");
            String eventTagResult = (String) result.get("eventTag");
            calendars[count] = new Calendar(null, dateResult, eventNameResult, descriptionResult, eventTagResult);
            count++;

        }
        return calendars;
    }

    public void addcalendar(Date date, String eventName, String description, String eventTag) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
