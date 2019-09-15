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
public class JobApplicationDao {
    private MongoClient mongoClient;
    private DB database;
    private DBCollection collection;
    private SimpleDateFormat yearDateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public JobApplicationDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("jobapplications");
    }
    
    public DB getDatabase() {
        return database;
    }
    public DBCollection getCollection() {
        return collection;
    }
        
    public JobApplication[] getJobApplications(ObjectId jobApplicationId, ObjectId jobId, ObjectId userId, String coverLetter, String status, Date statusDate, String sort, int order) {  
        List<BasicDBObject> conditions = new ArrayList<>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor;//If the parameter fields are NULL, do not include them in query
        if (jobApplicationId != null) {
            conditions.add(new BasicDBObject("_id", jobApplicationId));
        }
        if (jobId != null) {
            conditions.add(new BasicDBObject("jobid", jobId));
        }
        if (userId != null) {
            conditions.add(new BasicDBObject("userid", userId));
        }
        if (coverLetter != null) {
            if (!coverLetter.isEmpty()) conditions.add(new BasicDBObject("title", compile(quote(coverLetter), CASE_INSENSITIVE)));
        }
        if (status != null) {
            if (!status.isEmpty()) conditions.add(new BasicDBObject("description", compile(quote(status), CASE_INSENSITIVE)));
        }
        if (statusDate != null) {
            if (!statusDate.toString().isEmpty()) conditions.add(new BasicDBObject("postdate", compile(quote(yearDateFormat.format(statusDate)), CASE_INSENSITIVE)));
        }
        if (conditions.size() == 0) {
            cursor = collection.find();            
        }
        else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }    
        cursor.sort(new BasicDBObject(sort, order));
        JobApplication[] jobApplications = new JobApplication[cursor.count()];//Initialize a User array, the size of the results returned

        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId jobApplicationIdResult = (ObjectId)result.get("_id");
            ObjectId jobIdResult = (ObjectId)result.get("jobid");
            ObjectId userIdResult = (ObjectId)result.get("userid");
            String coverLetterResult = (String)result.get("coverletter");
            String statusResult = (String)result.get("status");
            Date statusDateResult = (Date)result.get("statusdate");;
            jobApplications[count] = new JobApplication(jobApplicationIdResult, jobIdResult, userIdResult, coverLetterResult, statusResult, statusDateResult);
            count ++;
        }
        return jobApplications;
    }
    
    public boolean addJobApplication(JobApplication jobApplication) {//Simple add to Mongo Database
        try {
            BasicDBObject newRecord = new BasicDBObject();
            newRecord.put("jobid", jobApplication.getJobId());
            newRecord.put("userid", jobApplication.getUserId());
            newRecord.put("coverletter", jobApplication.getCoverLetter());
            newRecord.put("status", jobApplication.getStatus());
            newRecord.put("statusdate", jobApplication.getStatusDate());
            collection.insert(newRecord);  
            jobApplication.setJobApplicationId((ObjectId)newRecord.get("_id"));
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }  
        public boolean editJobApplication(JobApplication jobApplication) { //Edit job application in database based on _id
        try {
            BasicDBObject query = new BasicDBObject().append("_id", jobApplication.getJobApplicationId());
            BasicDBObject records = new BasicDBObject();
            BasicDBObject update = new BasicDBObject();
            if (jobApplication.getJobId() != null) records.append("jobid", jobApplication.getJobId());
            if (jobApplication.getUserId() != null) records.append("userid", jobApplication.getUserId());
            if (jobApplication.getCoverLetter() != null) records.append("coverletter", jobApplication.getCoverLetter());
            if (jobApplication.getStatus() != null) records.append("status", jobApplication.getStatus());
            if (jobApplication.getStatusDate() != null) records.append("statusdate", jobApplication.getStatusDate());
            update.append("$set", records);
            collection.update(query, update);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    } 
    
    public boolean deleteJobApplication(ObjectId jobApplicationId) { //Simple Delete from Database, based on _id
        try {
            BasicDBObject query = new BasicDBObject();
            query.put("_id", jobApplicationId);
            collection.remove(query);}
        catch (Exception ex) {
            return false;
        }
        return true;
    }
}
