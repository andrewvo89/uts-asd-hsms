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
    
    public DB getDatabase() {
        return database;
    }
    
    
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate, String sort, int order) {  
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
        cursor.sort(new BasicDBObject(sort, order));
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
    
    public boolean addJob(Job job) {//Simple add to Mongo Database
        try {
            BasicDBObject newRecord = new BasicDBObject();
            newRecord.put("title", job.getTitle());
            newRecord.put("description", job.getDescription());
            newRecord.put("worktype", job.getWorkType());
            newRecord.put("department", job.getDepartment());
            newRecord.put("status", job.getStatus());
            newRecord.put("postdate", new Date());
            newRecord.put("closedate", job.getCloseDate());
            collection.insert(newRecord);  
            job.setJobId((ObjectId)newRecord.get("_id"));
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }  
        public boolean editJob(Job job) { //Edit job in database based on _id
        try {
            BasicDBObject query = new BasicDBObject().append("_id", job.getJobId());
            BasicDBObject records = new BasicDBObject();
            BasicDBObject update = new BasicDBObject();
            if (job.getTitle() != null) records.append("title", job.getTitle());
            if (job.getDescription() != null) records.append("description", job.getDescription());
            if (job.getWorkType() != null) records.append("worktype", job.getWorkType());
            if (job.getDepartment() != null) records.append("department", job.getDepartment());
            if (job.getStatus() != null) records.append("status", job.getStatus());
            //Need to do a check if status change so old date turns into new date
            if (job.getCloseDate() != null) records.append("closedate", job.getCloseDate());
            update.append("$set", records);
            collection.update(query, update);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    } 
    
    public boolean deleteJob(ObjectId jobId) { //Simple Delete from Database, based on _id
        try {
            BasicDBObject query = new BasicDBObject();
            query.put("_id", jobId);
            collection.remove(query);}
        catch (Exception ex) {
            return false;
        }
        return true;
    }
}
