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
import org.bson.Document;
import org.bson.types.ObjectId;

/**
 *
 * @author Andrew
 */
public class UserDao {
    MongoClient mongoClient;
    DB database;
    DBCollection collection;

    public UserDao(MongoClient mongoClient) {
        this.mongoClient = mongoClient;
        
        database = mongoClient.getDB("heroku_r0hsk6vb");
        collection = database.getCollection("users");
    }
    //get all users using no parameters
    public User[] getUsers() {
        DBCursor cursor = collection.find();
        User[] users = new User[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId userId = (ObjectId)result.get("_id");
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            String email = (String)result.get("email");
            String password = (String)result.get("password");
            int userRole = (int)result.get("userRole");
            users[count] = new User(userId, firstName, lastName, email, password, department, userRole);
            count ++;
        }
        return users;
    }
    //gets a user using two parametercs, objectID and userId
    public User getUser(ObjectId userId) {
        BasicDBObject query = new BasicDBObject();
        query.put("_id", userId.toString());
        DBCursor cursor = collection.find(query);
        DBObject result = cursor.one();
        
        if (result != null) {
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            String email = (String)result.get("email");
            String password = (String)result.get("password");
            int userRole = (int)result.get("uerRole");
            return new User(userId, firstName, lastName, email, password, department, userRole);
        }        
        return null;        
    } //gets a user using two parameters, email and password (e.g. for login)
        public User getUser(String email, String password) {
        BasicDBObject query = new BasicDBObject();
        List<BasicDBObject> queryList = new ArrayList<BasicDBObject>();
        queryList.add(new BasicDBObject("email", email));
        queryList.add(new BasicDBObject("password", password));
        query.put("$and", queryList);
        DBCursor cursor = collection.find(query);
        DBObject result = cursor.one();
        
        if (result != null) {
            ObjectId userId = (ObjectId)result.get("_id");
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            int userRole = (int)result.get("userRole");
            return new User(userId, firstName, lastName, email, password, department, userRole);
        }
        return null;        
    }
    
    public void addUser(String firstName, String lastName, String email, String password, String department, int userRole) {
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
    
    public void deleteUser(ObjectId userId) {
        BasicDBObject query = new BasicDBObject();
        query.put("_id", userId);
        collection.remove(query);
    }
    
    public void editUser(ObjectId userId, String firstName, String lastName, String email, String password, String department, int userRole) {
        BasicDBObject query = new BasicDBObject();
        query.put("_id", userId);
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