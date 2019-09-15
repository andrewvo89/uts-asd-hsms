/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.*;
import uts.asd.hsms.model.dao.*;
/**
 *
 * @author Griffin
 */
public class AttendanceController {
    private AttendanceDao attendanceDao;
    private TutorialDao tutorialDao;

    public AttendanceController(HttpSession session) {
        attendanceDao = (AttendanceDao)session.getAttribute("attendanceDao");
        tutorialDao = (TutorialDao)session.getAttribute("tutorialDao");
    }
    
    public Attendance[] getStudentByClass(ObjectId refStudentId, int studentId, String firstName, String lastName, String wk1, String wk2, String wk3, String wk4, String wk5, String wk6, String wk7, String wk8, String wk9, String wk10, String tutorialId, String sort, int order){
        return attendanceDao.getAttendance(refStudentId, studentId, firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId, sort, order);
    }
}
