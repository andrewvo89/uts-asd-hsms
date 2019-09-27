/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.*;
import uts.asd.hsms.model.dao.*;

/**
 *
 * @author Griffin
 */
public class TutorialController {
    private AttendanceDao attendanceDao;
    private TutorialDao tutorialDao;
    
    public TutorialController(HttpSession session) {
        tutorialDao = (TutorialDao)session.getAttribute("tutorialDao");
        attendanceDao = (AttendanceDao)session.getAttribute("attendanceDao");
    }
    
    public Tutorial[] getTutorials(ObjectId refId, String tutorialId, String department, int grade, ObjectId userId, int tutSize, String sort, int order) {
        return tutorialDao.getTutorials(refId, tutorialId, department, grade, userId, tutSize, sort, order);
    }
    
}
