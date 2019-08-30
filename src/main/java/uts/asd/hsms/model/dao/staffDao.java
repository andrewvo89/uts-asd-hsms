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
import java.util.Arrays;
import java.util.List;
import static java.util.regex.Pattern.*;
import org.bson.Document;
import org.bson.types.ObjectId;

/**
 *
 * @author alvin
 */
public class staffDao {
    MongoClient mongoClient;
    DB database;
    DBCollection collection;

    public staffDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;        
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("staffcontact");
    }

    public DB getDatabase() {
        return database;
    }
    //get all Staff using no parameters
    public Staff[] getstaff() {
        DBCursor cursor = collection.find();
        cursor.sort(new BasicDBObject("firstName", 1));
        Staff[] staff = new Staff[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId staffId = (ObjectId)result.get("_id");
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            String email = (String)result.get("email");
            String password = (String)result.get("password");
            int userRole = (int)result.get("userRole");
            staff[count] = new Staff(staffId, firstName, lastName, email, password, department, userRole);
            count ++;
        }
        Arrays.sort(staff, 0, 1);
        return staff;
    }
    public Staff[] getstaff(ObjectId staffId, String firstName, String lastName, String email, String password, String department, int userRole) {
        List<BasicDBObject> conditions = new ArrayList<BasicDBObject>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor;
        if (staffId != null) conditions.add(new BasicDBObject("_id", staffId));
        if (firstName != null) {
            if (!firstName.isEmpty()) conditions.add(new BasicDBObject("firstName", compile(quote(firstName.trim()), CASE_INSENSITIVE)));
        }
        if (lastName != null) {
            if (!lastName.isEmpty()) conditions.add(new BasicDBObject("lastName", compile(quote(lastName.trim()), CASE_INSENSITIVE)));
        }
        if (email != null) {
            if (!email.isEmpty()) conditions.add(new BasicDBObject("email", compile(quote(email.trim()), CASE_INSENSITIVE)));
        }
        if (password != null) {
            if (!password.isEmpty()) conditions.add(new BasicDBObject("password", compile(quote(password.trim()), CASE_INSENSITIVE)));
        }
        if (department != null) {
            if (!department.isEmpty()) {
                if (!department.equals("All")) conditions.add(new BasicDBObject("department", compile(quote(department), CASE_INSENSITIVE)));
            }
        }
        if (userRole != 0) conditions.add(new BasicDBObject("userRole", userRole));
        if (conditions.size() == 0) {
            cursor = collection.find();
        }
        else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }
        cursor.sort(new BasicDBObject("firstName", 1));
        Staff[] staff = new Staff[cursor.count()];

        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId staffIdResult = (ObjectId)result.get("_id");
            String firstNameResult = (String)result.get("firstName");
            String lastNameResult = (String)result.get("lastName");
            String emailResult = (String)result.get("email");
            String passwordResult = (String)result.get("password");
            String departmentResult = (String)result.get("department");
            int userRoleResult = (int)result.get("userRole");
            staff[count] = new Staff(staffIdResult, firstNameResult, lastNameResult, emailResult, passwordResult, departmentResult, userRoleResult);
            count ++;
            }
            return staff;
    }
        //gets a user using one parameters, objectID 
        public Staff getstaff(ObjectId staffId) {
            BasicDBObject query = new BasicDBObject();
            query.put("_id", staffId);
            DBCursor cursor = collection.find(query);
            DBObject result = cursor.one();
            if (result != null) {
                String firstName = (String)result.get("firstName");
                String lastName = (String)result.get("lastName");
                String department = (String)result.get("department");
                String email = (String)result.get("email");
                String password = (String)result.get("password");
                int userRole = (int)result.get("userRole");
                return new Staff(staffId, firstName, lastName, email, password, department, userRole);
            }       
            return null;        
        } 
        //gets a Staff using two parameters, email and password (e.g. for login)
        public Staff getstaff(String email, String password) {
        BasicDBObject query = new BasicDBObject();
        List<BasicDBObject> queryList = new ArrayList<BasicDBObject>();
        queryList.add(new BasicDBObject("email", email));
        queryList.add(new BasicDBObject("password", password));
        query.put("$and", queryList);
        DBCursor cursor = collection.find(query);
        DBObject result = cursor.one();
        
        if (result != null) {
            ObjectId staffId = (ObjectId)result.get("_id");
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            int userRole = (int)result.get("userRole");
            return new Staff(staffId, firstName, lastName, email, password, department, userRole);
        }
        return null;        
    }
    
    public void addstaff(String firstName, String lastName, String email, String password, String department, int userRole) {
        BasicDBObject newRecord = new BasicDBObject();
        //newRecord.put("teacherId", teacherID);
        newRecord.put("firstName", firstName);
        newRecord.put("lastName", lastName);
        newRecord.put("email", email);
        newRecord.put("password", password);
        newRecord.put("department", department);
        newRecord.put("userRole", userRole);
        collection.insert(newRecord);
    }
    
    public void deletestaff(ObjectId staffId) {
        BasicDBObject query = new BasicDBObject();
        query.put("_id", staffId);
        collection.remove(query);
    }
    
    public void editstaff(ObjectId staffId, String firstName, String lastName, String email, String password, String department, int userRole) {
        BasicDBObject query = new BasicDBObject();
        query.put("_id", staffId);
        BasicDBObject newRecord = new BasicDBObject(); 
        newRecord.put("firstName", firstName);
        newRecord.put("lastName", lastName);
        newRecord.put("email", email);
        newRecord.put("password", password);
        newRecord.put("department", department);
        newRecord.put("userRole", userRole);
        collection.update(query, newRecord);        
    }

}