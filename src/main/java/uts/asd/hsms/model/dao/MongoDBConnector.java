/*
 * Author: Georges Bou Ghantous
 *
 * This class provides the methods to establish connection between ASD-Demo-app
 * and MongoDBLab cloud Database. The data is saved dynamically on mLab cloud database as
 * as JSON format.
 */
package uts.asd.hsms.model.dao;

import java.net.UnknownHostException;
import com.mongodb.client.MongoCollection;
import org.bson.Document;
import java.util.*;
import uts.asd.hsms.model.*;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;

public class MongoDBConnector {

    private List<Document> users = new ArrayList();
    private String user;
    private String password;

    public MongoDatabase getMongoDB(){
       MongoClientURI uri = new MongoClientURI("mongodb://" + this.user + ":" + this.password + "@ds123196.mlab.com:23196/heroku_r0hsk6vb");
       MongoDatabase db;
       try (MongoClient client = new MongoClient(uri)) {
            db = client.getDatabase(uri.getDatabase());
       }
       return db;
    }
    
    public MongoDBConnector(String user, String password) throws UnknownHostException {
        this.user = user;
        this.password = password;
    }
}
