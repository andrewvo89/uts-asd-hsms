/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;

import java.net.UnknownHostException;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Assert;
import static org.junit.Assert.*;
/**
 *
 * @author ADMIN
 */
public class MavenJUnitTest {
    private static MongoDBConnector mdb;
    public MavenJUnitTest() {
        
    }
    @BeforeClass
    public static void setUpClass() throws UnknownHostException {
        System.out.println("\n<-- Starting test -->");
        mdb = new MongoDBConnector();
    }
}
