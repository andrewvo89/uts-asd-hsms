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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import static java.util.regex.Pattern.CASE_INSENSITIVE;
import static java.util.regex.Pattern.compile;
import static java.util.regex.Pattern.quote;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Leave;

/**
 *
 * @author MatthewHellmich
 */
public class LeaveDao {
    MongoClient mongoClient;
    DB database;
    DBCollection collection; 
    
    public LeaveDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("leaves");
    }

    public DB getDatabase() {
        return database;
    }
    
    public Leave[] getLeave(ObjectId leaveId, String firstName, String lastName, String email, String leaveType, Date leaveTo, Date leaveFrom, String department) {
        List<BasicDBObject> conditions = new ArrayList<BasicDBObject>();
        BasicDBObject leaveQuery = new BasicDBObject();
        DBCursor cursor = null;//If the parameter fields are NULL, do not include them in query
        if (leaveId != null) conditions.add(new BasicDBObject("_id", leaveId));
        if (firstName != null) {
            if (!firstName.isEmpty()) conditions.add(new BasicDBObject("firstname", compile(quote(firstName), CASE_INSENSITIVE)));
        }
        if (lastName != null) {
            if (!lastName.isEmpty()) conditions.add(new BasicDBObject("lastname", compile(quote(lastName), CASE_INSENSITIVE)));
        }
        if (email != null) {
            if (!email.isEmpty()) conditions.add(new BasicDBObject("email", (email)));
        }
        if (leaveType != null) {
            if (!leaveType.isEmpty()) conditions.add(new BasicDBObject("location", compile(quote(leaveType), CASE_INSENSITIVE)));
        }
        if (department != null) {
            if (!department.isEmpty()) {
                if (!department.equals("All")) conditions.add(new BasicDBObject("department", compile(quote(department), CASE_INSENSITIVE)));
            }
        }
        
        //cursor.sort(new BasicDBObject(sort, order));
        Leave[] leaves = new Leave[cursor.count()]; //Initialize a Leave array, the size of the results returned

        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId leaveIdResult = (ObjectId)result.get("_id");
            String firstNameResult = (String)result.get("firstName");
            String lastNameResult = (String)result.get("lastName");
            String emailResult = (String)result.get("email");
            String leaveTypeResult = (String)result.get("leaveType");
            Date leaveToResult = (Date)result.get("leaveTo");
            Date leaveFromdResult = (Date)result.get("leaveFrom");
            String departmentResult = (String)result.get("department");
            leaves[count] = new Leave(leaveIdResult, firstNameResult, lastNameResult, emailResult, leaveTypeResult, leaveToResult, leaveFromdResult, departmentResult);
            count ++;
        }
        return leaves;
    }
}
