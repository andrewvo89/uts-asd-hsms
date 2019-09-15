/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;

import com.mongodb.MongoClient;
import java.net.UnknownHostException;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Assert;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import uts.asd.hsms.model.User;
/**
 *
 * @author ADMIN
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MavenJUnitTest {
    private static MongoDBConnector mongoDbConnector;  
    private static MongoClient mongoClient;
    private static UserDao userDao;

    public MavenJUnitTest() {     
    }
    
    public void printDivider() {
        System.out.println("--------------------------------------------------------------------------");;
    }
    
    @BeforeClass
    public static void setUpClass() throws UnknownHostException {
        System.out.println("--------------------------------------------------------------------------");
        System.out.println("<-- Starting JUnit Tests -->");
        System.out.println("--------------------------------------------------------------------------");
        mongoDbConnector = new MongoDBConnector();
        mongoClient = mongoDbConnector.openConnection();
        mongoDbConnector = new MongoDBConnector();
        userDao = new UserDao(mongoClient); 
    }
    @Test
    public void test101() throws UnknownHostException {
        printDivider();
        System.out.println("<-- Test #101 - Establish Connection to MongoDB -->");
        printDivider();
        Assert.assertNotNull("Cannot establish connection to Mongo DB", mongoDbConnector.getMongoDB());
        printDivider();
        System.out.println("<-- Test #101 - Test Passed -->");
        printDivider();
        
    }
    @Test
    public void test102() throws UnknownHostException {
        printDivider();
        System.out.println("<-- Test #102 - Fetch All Users from MongoDB -->");
        printDivider();
        Assert.assertNotNull("Cannot fetch all users from Users collection of MongoDB", userDao.getUsers(null, null, null, null, null, null, null, null, 0, "firstname", 1)[0]);
        printDivider();
        System.out.println("<-- Test #102 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test103() throws UnknownHostException {
        User user = new User(null, "Test", "User", "123456789", "Test", "test@hsms.edu.au", "TestUser!", "Administration", 1);
        printDivider();
        System.out.println("<-- Test #103 - Add a User to MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot add a new User to Users collection of MongoDB", userDao.addUser(user));
        printDivider();
        System.out.println("<-- Test #103 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test104() throws UnknownHostException {
        User testUser = userDao.getUsers(null, "Test", "User", "123456789", "Test", "test@hsms.edu.au", "TestUser!", "Administration", 1, "firstname", 1)[0];
        User user = new User(testUser.getUserId(), "TestEdit", "UserEdit", "987564321", "TestEdit", "testedit@hsms.edu.au", "TestUser!", "Principal", 2);
        printDivider();
        System.out.println("<-- Test #104 - Edit a User from MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot edit the User \"Test User\" from Users collection of MongoDB", userDao.editUser(user));
        printDivider();
        System.out.println("<-- Test #104 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test105() throws UnknownHostException {
        User testUser = userDao.getUsers(null, "TestEdit", "UserEdit", "987564321", "TestEdit", "testedit@hsms.edu.au", "TestUser!", "Principal", 2, "firstname", 1)[0];
        printDivider();
        System.out.println("<-- Test #105 - Delete a User from MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot delete the User \"Test User\" from Users collection of MongoDB", userDao.deleteUser(testUser.getUserId()));
        printDivider();
        System.out.println("<-- Test #105 - Test Passed -->");
        printDivider();
    }
    @AfterClass
    public static void tearDownClass() {
        System.out.println("--------------------------------------------------------------------------");
        System.out.println("<-- Unit Test Finished -->");      
        System.out.println("--------------------------------------------------------------------------");
    }
}
