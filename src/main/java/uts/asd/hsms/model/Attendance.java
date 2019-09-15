/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import java.io.Serializable;
import org.bson.types.ObjectId;
import javax.validation.constraints.*;


public class Attendance implements Serializable{
    
    private ObjectId refStudentId;
    private int studentId;
    private String firstName;
    private String lastName;
    private String wk1;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk2;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk3;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk4;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk5;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk6;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk7;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk8;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk9;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String wk10;
    @Size(min = 0, max = 1, message = "Limit entree to 1 character.")
    @Pattern(regexp = "P|L|A", message = "P = Present, L = Late, A = Away")
    private String tutorialId;
    
    public Attendance(ObjectId refStudentId, int studentId, String firstName, String lastName, String wk1, String wk2, String wk3, String wk4, String wk5, String wk6, String wk7, String wk8, String wk9, String wk10, String tutorialId){
        this.refStudentId = refStudentId;
        this.studentId = studentId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.wk1 = wk1;
        this.wk2 = wk2;
        this.wk3 = wk3;
        this.wk4 = wk4;
        this.wk5 = wk5;
        this.wk6 = wk6;
        this.wk7 = wk7;
        this.wk8 = wk8;
        this.wk9 = wk9;
        this.wk10 = wk10;
        this.tutorialId = tutorialId;
    }
    
    
    
    public ObjectId getRefStudentId() {
        return refStudentId;
    }
    public void setRefStudentId(ObjectId refStudentId) {
        this.refStudentId = refStudentId;
    }
    
    public int getStudentId() {
        return studentId;
    }
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getWk1() {
        return wk1;
    }
    public void setWk1(String wk1) {
        this.wk1 = wk1;
    }
    
    public String getWk2() {
        return wk2;
    }
    public void setWk2(String wk2) {
        this.wk2 = wk2;
    }
    
    public String getWk3() {
        return wk3;
    }
    public void setWk3(String wk3) {
        this.wk3 = wk3;
    }
    
    public String getWk4() {
        return wk4;
    }
    public void setWk4(String wk4) {
        this.wk4 = wk4;
    }
    
    public String getWk5() {
        return wk5;
    }
    public void setWk5(String wk5) {
        this.wk5 = wk5;
    }
    
    public String getWk6() {
        return wk6;
    }
    public void setWk6(String wk6) {
        this.wk6 = wk6;
    }
    
    public String getWk7() {
        return wk7;
    }
    public void setWk7(String wk7) {
        this.wk7 = wk7;
    }
    
    public String getWk8() {
        return wk8;
    }
    public void setWk8(String wk8) {
        this.wk8 = wk8;
    }
    
    public String getWk9() {
        return wk9;
    }
    public void setWk9(String wk9) {
        this.wk9 = wk9;
    }
    
    public String getWk10() {
        return wk10;
    }
    public void setWk10(String wk10) {
        this.wk10 = wk10;
    }
    
    public String getTutorialId(){
        return tutorialId;
    }
    public void setTutorialId(String tutorialId){
        this.tutorialId = tutorialId;
    }
    
    public String getRefStudentIdString() {
        return refStudentId.toString();
    }
}
