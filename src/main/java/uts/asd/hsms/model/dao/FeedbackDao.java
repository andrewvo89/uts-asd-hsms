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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.bson.types.ObjectId;
import static java.util.regex.Pattern.*;
/**
 *
 * @author Griffin
 */
public class FeedbackDao {
     MongoClient mongoClient;
     DB database;
     DBCollection collection;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    
    public FeedbackDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("feedback");
    }
    
    public DB getDatabase() {
        return database;
    }
    
    public Feedback[] getFeedback(ObjectId refCommentId, int commentId, String commSubject, String comment, Date commDate, Boolean escalated, Boolean archived, String sort, int order) {
        List<BasicDBObject> conditions = new ArrayList<BasicDBObject>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor; //if the parameter fields are NULL, do not include them in query
        if (refCommentId != null) conditions.add(new BasicDBObject("_id", refCommentId));
        if (commentId != 0) conditions.add(new BasicDBObject("commentId", commentId));
        if (commSubject != null) {
            if (!commSubject.isEmpty()) conditions.add(new BasicDBObject("commSubject", compile(quote(commSubject), CASE_INSENSITIVE)));
        }
        if (comment != null) {
            if (!comment.isEmpty()) conditions.add(new BasicDBObject("comment", compile(quote(comment), CASE_INSENSITIVE)));
        }
        if (commDate != null) {
            if (!commDate.toString().isEmpty()) conditions.add(new BasicDBObject("commDate", compile(quote(dateFormat.format(commDate)), CASE_INSENSITIVE)));
        }
        if (escalated != null) {
            conditions.add(new BasicDBObject("escalated", escalated));
        }
        if (archived != null) {
            conditions.add(new BasicDBObject("archived", archived));
        }
        
        if (conditions.size() == 0) {
            cursor = collection.find();
        } else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }
        cursor.sort(new BasicDBObject(sort, order));
        Feedback[] feedbacks = new Feedback[cursor.count()];
        
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId refCommentIdResult = (ObjectId)result.get("_id");
            int commentIdResult = (int)result.get("commentId");
            String commSubjectResult = (String)result.get("commSubject");
            String commentResult = (String)result.get("comment");
            Date commDateResult = (Date)result.get("commDate");
            Boolean escalatedResult = (Boolean)result.get("escalated");
            Boolean archivedResult = (Boolean)result.get("archived");
            feedbacks[count] = new Feedback(refCommentIdResult, commentIdResult, commSubjectResult, commentResult, commDateResult, escalatedResult, archivedResult);
            count ++;
        } 
        return feedbacks;
    }
    
    public boolean addFeedback (Feedback feedback) {
        try {
            BasicDBObject query = new BasicDBObject().append("_id", feedback.getRefCommentId());
            BasicDBObject records = new BasicDBObject();
            BasicDBObject update = new BasicDBObject();
            if (feedback.getCommentId() != 0) records.append("commentId", feedback.getCommentId());
            if (feedback.getCommSubject() != null) records.append("commSubject", feedback.getCommSubject());
            if (feedback.getComment() != null) records.append("comment", feedback.getComment());
            if (feedback.getCommDate() != null) records.append("commDate", feedback.getCommDate());
            if (feedback.getEscalated() != null) records.append("escalated", feedback.getEscalated());
            if (feedback.getArchived() != null) records.append("archived", feedback.getArchived());
            update.append("$set", records);
            collection.update(query, update);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }
    
    public boolean deleteFeedback (ObjectId refCommentId) {
        try {
            BasicDBObject query = new BasicDBObject();
            query.put("_id", refCommentId);
            collection.remove(query);}
        catch (Exception ex) {
            return false;
        }
        return true;
    }
}
