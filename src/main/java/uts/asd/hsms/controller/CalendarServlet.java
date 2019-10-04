/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Calendar;
import uts.asd.hsms.model.dao.CalendarDao;

/**
 *
 * @author MatthewHellmich
 */
public class CalendarServlet extends HttpServlet {

    private CalendarController calendarController;
    private HttpSession session;
    private CalendarDao calendarDao;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId calendarId;
    private Date date;
    private String eventName, description, eventTag;
    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    private CalendarValidator calendarValidator;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();
        calendarController = new CalendarController(session);
        calendarDao = (CalendarDao) session.getAttribute("calendarDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;

        String action = request.getParameter("action");
        if (action.equals("add")) {
            addCalendar();
        } else if (action.equals("edit")) {
            editCalendar();
        } else if (action.equals("delete")) {
            deleteCalendar();
        } else {
            response.sendRedirect("calendar.jsp");
        }
    }

    private void addCalendar() throws ServletException, IOException {
        try {
            date = format.parse(request.getParameter("dateAdd"));
        } catch (ParseException ex) {
            date = new Date();
        }
        eventName = request.getParameter("eventNameAdd");
        description = request.getParameter("descriptionAdd");
        eventTag = request.getParameter("eventTagAdd");

        Calendar calendar = new Calendar(null, date, eventName, description, eventTag);
        calendarDao.addCalendar(calendar);
        response.sendRedirect("calendar.jsp");
    }

    private void editCalendar() throws ServletException, IOException {
        Calendar oldCalendar = null;
        Calendar newCalendar = null;
        Calendar sessionUser = (Calendar) session.getAttribute("calendar");
        calendarId = new ObjectId(request.getParameter("calendarIdEdit"));
        try {
            date = format.parse(request.getParameter("dateEdit"));
        } catch (ParseException ex) {
            date = new Date();
        }
        eventName = request.getParameter("eventNameEdit");
        description = request.getParameter("descriptionEdit");
        eventTag = request.getParameter("eventTagEdit");
        String editModalErrorMessage = "";
        Boolean editSuccess = false;
        message.add("Edit User Result");
    }

    private void deleteCalendar() throws ServletException, IOException {

        calendarId = new ObjectId(request.getParameter("calendarIdDelete"));//Only perform if userid is found in database
        calendarDao.deleteCalendar(calendarId);
            boolean deleteSuccess = false;
            message.add("Delete Event Result");
//            if (calendarDao.getCalendar(calendarId, null, null, null, null)[0] != null) {
                Calendar calendar = calendarDao.getCalendar(calendarId, null, null, null, null)[0];
                String deletedCalendar = calendar.getEventName() + " " + calendar.getDescription();
                if (calendarDao.deleteCalendar(calendarId)) message.add(String.format("%s deleted successfully", deletedCalendar)); message.add("success"); deleteSuccess = true;
//            }
//            if (!deleteSuccess) message.add("Failed to delete event"); message.add("danger");
            session.setAttribute("message", message);
            response.sendRedirect("calendar.jsp");
    }

    private Date Date(String parameter) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
