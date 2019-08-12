package uts.asd.hsms.model;

import java.io.Serializable;
import java.util.*;

public class Users implements Serializable{
   
    private ArrayList<User> list = new ArrayList<>();

    public Users() {
    }

    public ArrayList<User> getList() {
        return list;
    }

    public void addUser(User user) {
        list.add(user);
    }

    public void removeUser(User user) {
        list.remove(user);
    }

    public User login(String email, String password) {
        for (User user : list) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    public User getUser(String email) {
        for (User user : list) {
            if (user.getEmail().equals(email)) {
                return user;
            }
        }
        return null;
    }

    public ArrayList<User> getMatches(String email) {
        ArrayList<User> matches = new ArrayList<>();
        for (User user : list) {
            if (user.getEmail().equals(email)) {
                matches.add(user);
            }
        }
        return matches;
    }

    public void deleteUser(String email) {
        User user = getUser(email);
        if (user != null) {
            removeUser(user);
        } else {
            System.out.println("User Doesn't exist!");
        }
    }
}
