/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Calendar;
import uts.asd.hsms.model.dao.CalendarDao;

/**
 *
 * @author MatthewHellmich
 */
public class CalendarController {
    private CalendarDao calendarDao;
    
    public CalendarController(HttpSession session) {
        calendarDao = (CalendarDao)session.getAttribute("calendarDao");
    }
    
    public Calendar[] getCalendars(ObjectId calendarId, Date date, String eventName, String description, String eventTag) {
        return calendarDao.getCalendars(calendarId, date, eventName, description, eventTag);
    }
}
