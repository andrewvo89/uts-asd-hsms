/*
 * Author: Andrew Vo-Nguyen
 *
 * This class provides the methods to establish connection between ASD-Demo-app
 * and MongoDBLab cloud Database. The data is saved dynamically on mLab cloud database as
 * as JSON format.
 */
package uts.asd.hsms.model.dao;

import java.net.UnknownHostException;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoDatabase;

public class MongoDBConnector {

    MongoClient mongoClient;
//    public MongoDatabase getMongoDB(){
//       MongoClientURI uri = new MongoClientURI("mongodb://" + this.user + ":" + this.password + "@ds123196.mlab.com:23196/heroku_r0hsk6vb");
//       MongoDatabase db;
//       try (MongoClient client = new MongoClient(uri)) {
//            db = client.getDatabase(uri.getDatabase());
//       }
//       return db;
//    }
    public MongoDatabase getMongoDB(){
       return mongoClient.getDatabase("heroku_r0hsk6vb");
    }
    
    public MongoDBConnector() throws UnknownHostException {
        String dbUrl = "ds123196.mlab.com";
        String dbPort = String.valueOf(23196);
        String dbUser = "heroku_r0hsk6vb";
        String dbPass = "gr128qe2kcsdjbgkhbj0r5ng4p";
        String dbName = "heroku_r0hsk6vb";
        String dbUri = String.format("mongodb://%s:%s@%s:%s/%s", dbUser, dbPass, dbUrl, dbPort, dbName);
        mongoClient = new MongoClient(new MongoClientURI(dbUri));
    }
    
    
    
    public MongoClient openConnection(){
        return this.mongoClient;
    }
    public void closeConnection() {
        mongoClient.close();
    }
}
