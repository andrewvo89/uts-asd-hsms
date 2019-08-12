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
<<<<<<< HEAD

    public void showall(Users users) {
        for (User u : users.getList()) {
            System.out.println(u.getName());
        }
    }

    public void add(User user) {
        MongoClientURI uri = new MongoClientURI("mongodb://" + this.owner + ":" + this.password + "@ds029496.mlab.com:29496/heroku_59pxdn6j");
        try (MongoClient client = new MongoClient(uri)) {
            MongoDatabase db = client.getDatabase(uri.getDatabase());
            users.add(new Document("Username", user.getEmail()).append("Password", user.getPassword()).append("Name", user.getName()).append("Phone", user.getPhone()));
            MongoCollection<Document> userlist = db.getCollection("ASD-Demo-app-users"); //Create a collection ASD-Demo-app-users on mLab
            userlist.insertMany(users);
        }
    }

    public void showUsers() {
        MongoClientURI uri = new MongoClientURI("mongodb://" + this.owner + ":" + this.password + "@ds029496.mlab.com:29496/heroku_59pxdn6j");
        try (MongoClient client = new MongoClient(uri)) {
            MongoDatabase db = client.getDatabase(uri.getDatabase());
            MongoCollection<Document> userlist = db.getCollection("ASD-Demo-app-users");
            try (MongoCursor<Document> cursor = userlist.find().iterator()) {
                while (cursor.hasNext()) {
                    System.out.println(cursor.next().toJson());
                }
            }
        }
    }

    public Users loadUsers() {
        MongoClientURI uri = new MongoClientURI("mongodb://" + this.owner + ":" + this.password + "@ds029496.mlab.com:29496/heroku_59pxdn6j");
        Users users;
        try (MongoClient client = new MongoClient(uri)) {
            MongoDatabase db = client.getDatabase(uri.getDatabase());
            users = new Users();
            MongoCollection<Document> userlist = db.getCollection("ASD-Demo-app-users");
            for (Document doc : userlist.find()) {
                User user = new User((String) doc.get("Name"), (String) doc.get("Username"), (String) doc.get("Password"), (String) doc.get("Phone"));
                users.addUser(user);
            }
        }
        return users;
    }

    public User user(String email, String password) {
        MongoClientURI uri = new MongoClientURI("mongodb://" + this.owner + ":" + this.password + "@ds029496.mlab.com:29496/heroku_59pxdn6j");
        User user;
        try (MongoClient client = new MongoClient(uri)) {
            MongoDatabase db = client.getDatabase(uri.getDatabase());
            MongoCollection<Document> userlist = db.getCollection("ASD-Demo-app-users");
            Document doc = userlist.find(and(eq("Username", email), eq("Password", password))).first();
            user = new User((String) doc.get("Name"), (String) doc.get("Username"), (String) doc.get("Password"), (String) doc.get("Phone"));
        }
        return user;
    }

    public int add(int a, int b) {
        return a + b;
    }

    public int subtract(int a, int b) {
        return a - b;
    }
=======
>>>>>>> parent of e8564ce... Merge branch 'andrew' of https://github.com/andrewvo89/uts-asd-hsms into andrew
}
