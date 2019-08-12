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
        collection = database.getCollection("teachers");
    }
    
    public User getUser(int teacherId) {
        BasicDBObject query = new BasicDBObject();
        query.put("teacherId", teacherId);
        DBCursor cursor = collection.find(query);
        DBObject result = cursor.one();
        
        int teacherID = (int)result.get("teacherId");
        String firstName = (String)result.get("firstName");
        String lastName = (String)result.get("lastName");
        String department = (String)result.get("department");
        String email = (String)result.get("email");
        String password = (String)result.get("password");
        String userRole = (String)result.get("firstName");
        
        User user = new User(teacherID, firstName, lastName, department, email, password, userRole);
        return user; 
        
    }
    
    public void addUser(String firstName, String lastName, String department, String email, String password, String userRole) {
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