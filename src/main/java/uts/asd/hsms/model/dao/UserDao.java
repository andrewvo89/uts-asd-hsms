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
import static java.util.regex.Pattern.*;
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

    public DB getDatabase() {
        return database;
    }
    
    public User[] getUsers(ObjectId userId, String firstName, String lastName, String phone, String location, String email, String password, String department, int userRole, String sort, int order) {
        List<BasicDBObject> conditions = new ArrayList<BasicDBObject>();
        BasicDBObject query = new BasicDBObject();
        DBCursor cursor;//If the parameter fields are NULL, do not include them in query
        if (userId != null) conditions.add(new BasicDBObject("_id", userId));
        if (firstName != null) {
            if (!firstName.isEmpty()) conditions.add(new BasicDBObject("firstname", compile(quote(firstName), CASE_INSENSITIVE)));
        }
        if (lastName != null) {
            if (!lastName.isEmpty()) conditions.add(new BasicDBObject("lastname", compile(quote(lastName), CASE_INSENSITIVE)));
        }
        if (phone != null) {
            if (!phone.isEmpty()) conditions.add(new BasicDBObject("phone", compile(quote(phone), CASE_INSENSITIVE)));
        }
        if (location != null) {
            if (!location.isEmpty()) conditions.add(new BasicDBObject("location", compile(quote(location), CASE_INSENSITIVE)));
        }
        if (email != null) {
            if (!email.isEmpty()) conditions.add(new BasicDBObject("email", email));
        }
        if (password != null) {
            if (!password.isEmpty()) conditions.add(new BasicDBObject("password", compile(quote(password), CASE_INSENSITIVE)));
        }
        if (department != null) {
            if (!department.isEmpty()) {
                if (!department.equals("All")) conditions.add(new BasicDBObject("department", compile(quote(department), CASE_INSENSITIVE)));
            }
        }
        if (userRole != 0) conditions.add(new BasicDBObject("userrole", userRole));
        if (conditions.size() == 0) {
            cursor = collection.find();
        }
        else {
            query.put("$and", conditions);
            cursor = collection.find(query);
        }
        cursor.sort(new BasicDBObject(sort, order));
        User[] users = new User[cursor.count()];//Initialize a User array, the size of the results returned

        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            ObjectId userIdResult = (ObjectId)result.get("_id");
            String firstNameResult = (String)result.get("firstname");
            String lastNameResult = (String)result.get("lastname");
            String phoneResult = (String)result.get("phone");
            String locationResult = (String)result.get("location");
            String emailResult = (String)result.get("email");
            String passwordResult = (String)result.get("password");
            String departmentResult = (String)result.get("department");
            int userRoleResult = (int)result.get("userrole");
            users[count] = new User(userIdResult, firstNameResult, lastNameResult, phoneResult, locationResult, emailResult, passwordResult, departmentResult, userRoleResult);
            count ++;
        }
        return users;
    }
    
    public boolean addUser(User user) {//Simple add to Mongo Database
        try {
            BasicDBObject newRecord = new BasicDBObject();
            newRecord.put("firstname", user.getFirstName());
            newRecord.put("lastname", user.getLastName());
            newRecord.put("phone", user.getPhone());
            newRecord.put("location", user.getLocation());
            newRecord.put("email", user.getEmail());
            newRecord.put("password", user.getPassword());
            newRecord.put("department", user.getDepartment());
            newRecord.put("userrole", user.getUserRole());
            collection.insert(newRecord);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    }   
    
    public boolean editUser(User user) { //Edit user in database based on _userId
        try {
            BasicDBObject query = new BasicDBObject().append("_id", user.getUserId());
            BasicDBObject records = new BasicDBObject();
            BasicDBObject update = new BasicDBObject();
            if (user.getFirstName() != null) records.append("firstname", user.getFirstName());
            if (user.getLastName() != null) records.append("lastname", user.getLastName());
            if (user.getPhone() != null) records.append("phone", user.getPhone());
            if (user.getLocation() != null) records.append("location", user.getLocation());
            if (user.getEmail() != null) records.append("email", user.getEmail());
            if (user.getDepartment() != null) records.append("department", user.getDepartment());
            if (user.getUserRole() != 0) records.append("userrole", user.getUserRole());  
            if (user.getPassword() != null) records.append("password", user.getPassword());        
            update.append("$set", records);
            collection.update(query, update);
        }
        catch (Exception ex) {
            return false;
        }
        return true;
    } 
    
    public boolean deleteUser(ObjectId userId) { //Simple Delete from Database, based on _userId
        try {
            BasicDBObject query = new BasicDBObject();
            query.put("_id", userId);
            collection.remove(query);}
        catch (Exception ex) {
            return false;
        }
        return true;
    }

}