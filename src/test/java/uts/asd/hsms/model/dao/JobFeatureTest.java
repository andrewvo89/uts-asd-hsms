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
import uts.asd.hsms.model.Job;

/**
 *
 * @author Andrew
 */
class JobIdResult {
    public static ObjectId jobIdResult;  
}

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JobFeatureTest {
    
    private static MongoDBConnector mongoDbConnector;  
    private static MongoClient mongoClient;
    private static JobDao jobDao;
    
    public void printDivider() {
        System.out.println("--------------------------------------------------------------------------");;
    }
    
    @BeforeClass
    public static void setUpClass() throws UnknownHostException {
        System.out.println("--------------------------------------------------------------------------");
        System.out.println("<-- Starting JUnit Tests for Feature 102 (Job Management) -->");
        System.out.println("--------------------------------------------------------------------------");
        mongoDbConnector = new MongoDBConnector();
        mongoClient = mongoDbConnector.openConnection();
        mongoDbConnector = new MongoDBConnector();
        jobDao = new JobDao(mongoClient); 
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
        System.out.println("<-- Test #102 - Fetch All Jobs from MongoDB -->");
        printDivider();
        Assert.assertNotNull("Cannot fetch all users from Users collection of MongoDB", jobDao.getJobs(null, null, null, null, null, null, null, null, true, "_id", 1));
        printDivider();
        System.out.println("<-- Test #102 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test103() throws UnknownHostException {
        Job job = new Job(null, "Test Job", "Test Description", "Full Time", "English", "Open", new Date(), new Date(), true);
        printDivider();
        System.out.println("<-- Test #103 - Add a Job to MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot add a new Job to Jobs collection of MongoDB", jobDao.addJob(job));
        JobIdResult.jobIdResult = job.getJobId();
        printDivider();
        System.out.println("<-- Test #103 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test104() throws UnknownHostException {
        Job testJob = jobDao.getJobs(JobIdResult.jobIdResult, null, null, null, null, null, null, null, null, "_id", 1)[0];
        Job job = new Job(testJob.getJobId(), "Test Job Edit", "Test Description Edit", "Part Time", "Math", "Open", new Date(), new Date(), true);
        printDivider();
        System.out.println("<-- Test #104 - Edit a Job from MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot edit the Job \"Test Job\" from Jobs collection of MongoDB", jobDao.editJob(job));
        printDivider();
        System.out.println("<-- Test #104 - Test Passed -->");
        printDivider();
    }
    @Test
    public void test105() throws UnknownHostException {
        Job testJob = jobDao.getJobs(JobIdResult.jobIdResult, null, null, null, null, null, null, null, null, "_id", 1)[0];
        printDivider();
        System.out.println("<-- Test #105 - Delete a Job from MongoDB -->");
        printDivider();
        Assert.assertTrue("Cannot delete the Job \"Test Job\" from Jobs collection of MongoDB", jobDao.deleteJob(testJob));
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
