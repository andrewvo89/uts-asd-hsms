/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.text.ParseException;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Calendar;
import uts.asd.hsms.model.dao.CalendarDao;
import java.text.SimpleDateFormat;

/**
 *
 * @author MatthewHellmich
 */
public class CalendarController {

    private CalendarDao calendarDao;

    public CalendarController(HttpSession session) {
        calendarDao = (CalendarDao) session.getAttribute("calendarDao");
    }

    public String[] getEventTagSearch(String eventTag) {
        String[] eventTagSearch = new String[4];
        for (int i = 0; i < eventTagSearch.length; i++) {
            eventTagSearch[i] = "";
        }
        if (eventTag == null) {
            eventTag = "";
        }
        eventTagSearch[0] = "checked";
        if (eventTag.equals("Personal")) {
            eventTagSearch[1] = "checked";
        }
        if (eventTag.equals("Work")) {
            eventTagSearch[2] = "checked";
        }
        if (eventTag.equals("School")) {
            eventTagSearch[3] = "checked";
        }
        return eventTagSearch;
    }

    public String[] getEventTagEdit(String eventTag) {
        String[] eventTagEdit = new String[3];
        for (int i = 0; i < eventTagEdit.length; i++) {
            eventTagEdit[i] = "";
        }
        if (eventTag.equals("Personal")) {
            eventTagEdit[0] = "checked";
        }
        if (eventTag.equals("Work")) {
            eventTagEdit[1] = "checked";
        }
        if (eventTag.equals("School")) {
            eventTagEdit[2] = "checked";
        }
        return eventTagEdit;
    }

    public Date getDateSearch(String dateSearch) throws ParseException {
        SimpleDateFormat yearMonthDayFormat = new SimpleDateFormat("yyyy-MM-dd");
        if (dateSearch != null) {
            Date dateSearches = yearMonthDayFormat.parse(dateSearch);
            return dateSearches;
        }
        return null;
    }

    public Calendar[] getCalendars(ObjectId calendarId, Date date, String eventName, String description, String eventTag, String sort, int order) {
        return calendarDao.getCalendar(calendarId, date, eventName, description, eventTag, sort, order);
    }

    public boolean addCalendar(Calendar calendar) {
        return calendarDao.addCalendar(calendar);
    }

    public boolean editCalendar(Calendar calendar) {
        return calendarDao.editCalendar(calendar);
    }
}
