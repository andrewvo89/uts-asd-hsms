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
    
    public User[] getUsers() {
        DBCursor cursor = collection.find();
        System.out.println("COUNT: " + cursor.count());
        User[] users = new User[cursor.count()];
        int count = 0;
        while (cursor.hasNext()) {
            DBObject result = cursor.next();
            int userId = (int)result.get("userId");
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            String email = (String)result.get("email");
            String password = (String)result.get("password");
            int userRole = (int)result.get("userRole");
            users[count] = new User(userId, firstName, lastName, department, email, password, userRole);
            count ++;
        }
        return users;
    }
    
    public User getUser(int userId) {
        BasicDBObject query = new BasicDBObject();
        query.put("userId", userId);
        DBCursor cursor = collection.find(query);
        DBObject result = cursor.one();
        
        if (result != null) {
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            String email = (String)result.get("email");
            String password = (String)result.get("password");
            int userRole = (int)result.get("uerRole");
            return new User(userId, firstName, lastName, department, email, password, userRole);
        }        
        return null;        
    }
        public User getUser(String email, String password) {
        BasicDBObject query = new BasicDBObject();
        List<BasicDBObject> queryList = new ArrayList<BasicDBObject>();
        queryList.add(new BasicDBObject("email", email));
        queryList.add(new BasicDBObject("password", password));
        query.put("$and", queryList);
        DBCursor cursor = collection.find(query);
        DBObject result = cursor.one();
        
        if (result != null) {
            int userId = (int)result.get("userId");
            String firstName = (String)result.get("firstName");
            String lastName = (String)result.get("lastName");
            String department = (String)result.get("department");
            int userRole = (int)result.get("userRole");
            return new User(userId, firstName, lastName, department, email, password, userRole);
        }
        return null;        
    }
    
    public void addUser(String firstName, String lastName, String department, String email, String password, int userRole) {
        BasicDBObject newRecord = new BasicDBObject();
        //newRecord.put("teacherId", teacherID);
        newRecord.put("firstName", firstName);
        newRecord.put("lastName", lastName);
        newRecord.put("department", department);
        newRecord.put("email", email);
        newRecord.put("password", password);
        newRecord.put("userRole", userRole);
        collection.insert(newRecord);
    }
//    
//    public User getUser(String userId, String password) throws SQLException {
//        
//        String sqlQuery = String.format("SELECT * FROM USERS WHERE userid = '%s'", userId);
//        System.out.println(sqlQuery);
//        ResultSet rs = st.executeQuery(sqlQuery);
//        while(rs.next()) {
//            User user = new User(rs.getString("userid"), rs.getString("firstname"),
//                         rs.getString("lastname"), rs.getString("email"),
//                         rs.getString("password"), rs.getBoolean("staff"));
//            if (user.passwordMatches(password)) {
//                return user;
//            }
//        }
//        
//        return null;
//        
//    }
//    
//    public boolean createUser(String userId, String firstName, String lastName, String email, String password, boolean staff) throws SQLException {
//        
//        String sqlQuery = String.format("INSERT INTO USERS VALUES('%s','%s','%s','%s','%s', %b)",
//                userId, firstName, lastName, email, password, staff);
//        System.out.println(sqlQuery);
//        int result = st.executeUpdate(sqlQuery);
//        
//        if (result > 0) {
//            return true;
//        }
//        
//        return false;
//        
//    }
//    
//    public boolean updateUser(String userId, String firstName, String lastName, String email, String password, boolean staff) throws SQLException {
//        
//        String sqlQuery = String.format("UPDATE USERS SET firstname = '%s', lastname = '%s', email = '%s', password = '%s', staff = %b WHERE userid = '%s'",
//                firstName, lastName, email, password, staff, userId);
//        System.out.println(sqlQuery);
//        int result = st.executeUpdate(sqlQuery);
//        
//        if (result > 0) {
//            return true;
//        }
//        
//        return false;
//        
//    }
//    
//    public void deleteUser(String userId) throws SQLException{
//        
//        String sqlQuery = String.format("DELETE FROM USERS WHERE userid = '%s'", userId);
//        st.executeUpdate(sqlQuery);
//        
//    }

}