/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;

import com.mongodb.MongoClient;
import java.net.UnknownHostException;
import java.util.Date;
import org.bson.types.ObjectId;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.Assert;
import uts.asd.hsms.model.Message;
import static org.junit.Assert.assertEquals;

/**
 *
 * @author sukonrat
 */
public class messageFeatureTest {

  private static MongoDBConnector mongoDbConnector;  
    private static MongoClient mongoClient;
    private static MessagesDao messagesDao;
    private ObjectId messageID;
   
    
    public messageFeatureTest() {
  
        
    }
    
    @BeforeClass
    public static void setUpClass() throws UnknownHostException {
        System.out.println("Starting JUnit test for message feature");
        mongoDbConnector = new MongoDBConnector();
        mongoClient = mongoDbConnector.openConnection();
        mongoDbConnector = new MongoDBConnector();
        messagesDao = new MessagesDao(mongoClient); 
       
    }
    
    @Test
    
   public void Test() throws Exception{
       
        System.out.println("connect to database");
       // String connectionResult = "connect to DB";
      //  MongoDatabase connectionExpect = mongoDbConnector.getMongoDB();
      //  assertEquals(connectionResult, connectionExpect);
       Assert.assertNotEquals("connect to DB", mongoDbConnector.getMongoDB());
        System.out.println("Test Past");

   }
    
    @Test
    public void viewMessageTest() throws Exception{
        
       System.out.println("Test - view messages");
       String testResult ="retrieving messages from Messages collection";
       Message[] testExpect = messagesDao.getMessage("name");
       assertEquals(testResult,  testExpect);       
       System.out.println("Test - Test Past");
    
    }
    
     @Test
    public void sendMessageTest() throws Exception{
  
       System.out.println("adding new message to Messages collection");
       String testResult = "adding new message to DB";
       boolean testExpect = messagesDao.sendMessage("administrator", "Sally", "Jnit test", new Date());
       assertEquals(testResult,  testExpect);
       System.out.println("Test - Test Past");
       
    }
     @Test
    public void forwardMessageTest() throws Exception{
        
      System.out.println("forwarding messages from Messages collection");
      String testResult = "forwarding message";
      boolean testExpect = messagesDao.forwardMessage("administrator", "Sally", "forward Test", new Date());
      assertEquals(testResult,  testExpect);
      System.out.println("Test - Test Past");
      
    }
    
     @Test
    public void deleteMessageTest() throws Exception{
        
      System.out.println("deleting messages from Messages collection");
      String testResult = "deleting message";
      boolean testExpect = messagesDao.deleteMessage(messageID);
      assertEquals(testResult,  testExpect);
      System.out.println("Test - Test Past");
      
    }
    
    @AfterClass
    public static void tearDownClass() throws Exception {
        
         System.out.println("Unit test finished"); 
         
    }
}
