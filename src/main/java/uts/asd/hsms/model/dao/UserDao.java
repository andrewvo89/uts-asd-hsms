/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;
import uts.asd.hsms.model.User;

/**
 *
 * @author neko
 */
public class UserDao {
    
    private Statement st;

    public UserDao(Connection conn) throws SQLException {
        st = conn.createStatement();
    }
    
    public User getUser(String userId) throws SQLException {
        
        String sqlQuery = String.format("SELECT * FROM USERS WHERE userid = '%s'", userId);
        ResultSet rs = st.executeQuery(sqlQuery);
        while(rs.next()) {
            return new User(rs.getString("userid"), rs.getString("firstname"),
                    rs.getString("lastname"), rs.getString("email"),
                    rs.getString("password"));
        }
        
        return null;
        
    }
    
    public User getUser(String userId, String password) throws SQLException {
        
        String sqlQuery = String.format("SELECT * FROM USERS WHERE userid = '%s'", userId);
        System.out.println(sqlQuery);
        ResultSet rs = st.executeQuery(sqlQuery);
        while(rs.next()) {
            User user = new User(rs.getString("userid"), rs.getString("firstname"),
                         rs.getString("lastname"), rs.getString("email"),
                         rs.getString("password"));
            if (user.passwordMatches(password)) {
                return user;
            }
        }
        
        return null;
        
    }
    
    public void createUser(String userId, String firstName, String lastName, String email, String password) throws SQLException {
        
        String sqlQuery = String.format("INSERT INTO USERS VALUES('%s','%s','%s','%s','%s')",
                userId, firstName, lastName, email, password);
        System.out.println(sqlQuery);
        st.executeUpdate(sqlQuery);
        
    }
    
    public void updateUser(String userId, String firstName, String lastName, String email, String password) throws SQLException {
        
        String sqlQuery = String.format("UPDATE USERS WHERE userid = '%s' SET firstname = '%s', lastname = '%s', email = '%s', password = '%s')",
                firstName, lastName, email, password);
        st.executeUpdate(sqlQuery);
        
    }
    
    public void deleteUser(String userId) throws SQLException{
        
        String sqlQuery = String.format("DELETE FROM USERS WHERE userid = '%s'", userId);
        st.executeUpdate(sqlQuery);
        
    }

}