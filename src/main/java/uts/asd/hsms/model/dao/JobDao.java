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
import org.bson.Document;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.*;

/**
 *
 * @author Andrew
 */
public class JobDao {
    private MongoClient mongoClient;
    private DB database;
    private DBCollection collection;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public JobDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("jobs");
    }
    
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate) {  
        List<BasicDBObject> conditions = new ArrayList<>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor;//If the parameter fields are NULL, do not include them in query
        if (jobId != null) {
            conditions.add(new BasicDBObject("_id", jobId));
        }
        if (title != null) {
            if (!title.isEmpty()) conditions.add(new BasicDBObject("title", compile(quote(title), CASE_INSENSITIVE)));
        }
        if (description != null) {
            if (!description.isEmpty()) conditions.add(new BasicDBObject("description", compile(quote(description), CASE_INSENSITIVE)));
        }
        if (workType != null) {
            if (!workType.isEmpty()) {
                if (!workType.equals("All")) conditions.add(new BasicDBObject("worktype", compile(quote(workType), CASE_INSENSITIVE)));
            }
        }
        if (department != null) {
            if (!department.isEmpty()) {
                if (!department.equals("All")) conditions.add(new BasicDBObject("department", compile(quote(department), CASE_INSENSITIVE)));
            }
        }
        if (status != null) {
            if (!status.isEmpty()) {
                if (!status.equals("All")) conditions.add(new BasicDBObject("status", compile(quote(status), CASE_INSENSITIVE)));
            }
        }
        if (postDate != null) {
            if (!postDate.toString().isEmpty()) conditions.add(new BasicDBObject("postdate", compile(quote(dateFormat.format(postDate)), CASE_INSENSITIVE)));
        }
        if (closeDate != null) {
            if (!closeDate.toString().isEmpty()) conditions.add(new BasicDBObject("closedate", compile(quote(dateFormat.format(closeDate)), CASE_INSENSITIVE)));
        }
        if (conditions.size() == 0) {
            cursor = collection.find();            
        }
        else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }    
        //cursor.sort(new BasicDBObject("closeDate", 1));
        Job[] jobs = new Job[cursor.count()];//Initialize a User array, the size of the results returned

        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId jobIdResult = (ObjectId)result.get("_id");
            String titleResult = (String)result.get("title");
            String descriptionResult = (String)result.get("description");
            String workTypeResult = (String)result.get("worktype");
            String departmentResult = (String)result.get("department");
            String statusResult = (String)result.get("status");
            Date postDateResult = (Date)result.get("postdate");
            Date closeDateResult = (Date)result.get("closedate");
            jobs[count] = new Job(jobIdResult, titleResult, descriptionResult, workTypeResult, departmentResult, statusResult, postDateResult, closeDateResult);
            count ++;
        }
        return jobs;
    }
}
