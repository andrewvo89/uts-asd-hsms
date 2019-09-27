/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import static uts.asd.hsms.controller.StaffdirectoryServlet.toProperCase;
import uts.asd.hsms.model.dao.CalendarDao;

/**
 *
 * @author MatthewHellmich
 */
public class CalendarServlet extends HttpServlet {
    private HttpSession session;
    private CalendarDao calendarDao;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId calendarId;
    private Date date;
    private String eventName, description, eventTag;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();         
        //calendarController = new UserController(session);
        calendarDao = (CalendarDao)session.getAttribute("calendarDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;

        String action = request.getParameter("action");             
        if (action.equals("add")) addCalendar();
        else if (action.equals("edit")) editCalendar();
        else if (action.equals("delete")) deleteCalendar();
        else response.sendRedirect("calendar.jsp");        
    }

    private void addCalendar() throws ServletException, IOException {
        //date = request.getParameter("dateAdd");
        eventName = toProperCase(request.getParameter("lastNameAdd"));
        description = request.getParameter("departmentAdd");
        eventTag = request.getParameter("emailAdd").toLowerCase();
        
//        Calendar calendar = new Calendar(null, date, eventName, description, eventTag) {};
//        CalendarValidator calendarValidator = new CalendarValidator(calendar);
//        String[] errorMessages = calendarValidator.validatecalendar();
//        
//        if (errorMessages != null) {
//            session.setAttribute("dateAdd", date);
//            session.setAttribute("eventNameAdd", eventName);
//            session.setAttribute("descriptionAdd", description);
//            session.setAttribute("eventTagAdd", eventTag);
//            message.add("Add User Result");
//        } else {
//            calendarDao.addcalendar(date, eventName, description, eventTag);
//            message.add("Add Calendar Event");
//            session.setAttribute("message", message);
//        }
    }

    private void editCalendar() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void deleteCalendar() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private Date Date(String parameter) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}

