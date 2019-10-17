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
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import uts.asd.hsms.model.Feedback;
/**
 *
 * @author Griffin
 */
class RefCommentIdResult {
    public static ObjectId refCommentIdResult;
}

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class FeedbackFeatureTest {
    private static MongoDBConnector mongoDbConnector;
    private static MongoClient mongoClient;
    private static FeedbackDao feedbackDao;
    
    public void printDivider() {
        System.out.println("--------------------------------------------------------------------------");
    }
    
    @BeforeClass
    public static void setUpClass() throws UnknownHostException {
        System.out.println("--------------------------------------------------------------------------");
        System.out.println("<-- Starting JUnit Tests for Feature 106 (Feedback System) -->");
        System.out.println("--------------------------------------------------------------------------");
        mongoDbConnector = new MongoDBConnector();
        mongoClient = mongoDbConnector.openConnection();
        mongoDbConnector = new MongoDBConnector();
        feedbackDao = new FeedbackDao(mongoClient); 
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
        System.out.println("<-- Test #102 - Fetch All Feedback from MongoDB -->");
        printDivider();
        Assert.assertNotNull("Cannot fetch all feedbacks from Feedbacks collection of MongoDB", feedbackDao.getFeedback(null, 0, null, null, null, null, null, "commentId", 1));
        printDivider();
        System.out.println("<-- Test #102 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test103() throws UnknownHostException {
        Feedback feedback = new Feedback(null, 65, "Other", "Nag nag nag", new Date(), false, false);
        printDivider();
        System.out.println("<-- Test #103 - Add a feedback to MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot add a new Job to Jobs collection of MongoDB", feedbackDao.addFeedback(feedback));
        RefCommentIdResult.refCommentIdResult = feedback.getRefCommentId();
        printDivider();
        System.out.println("<-- Test #103 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test104() throws UnknownHostException {
        Feedback testFeedback = feedbackDao.getFeedback(null, 0, null, null, null, null, null, "commentId", 1)[0];
        Feedback feedback = new Feedback(testFeedback.getRefCommentId(), 155, "Other", "I broke my glasses testing", new Date(), false, true);
        printDivider();
        System.out.println("<-- Test #104 - Archive aka Edit Feedback from MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot edit the Job \"Test Feedback\" from Jobs collection of MongoDB", feedbackDao.addFeedback(feedback));
        RefCommentIdResult.refCommentIdResult = feedback.getRefCommentId();
        printDivider();
        System.out.println("<-- Test #104 - Test Passed -->");
        printDivider();
    }
    @AfterClass
    public static void tearDownClass() {
        System.out.println("--------------------------------------------------------------------------");
        System.out.println("<-- Unit Test Finished -->");      
        System.out.println("--------------------------------------------------------------------------");
    }
}
