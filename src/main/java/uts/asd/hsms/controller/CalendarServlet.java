/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.controller.validator.CalendarValidator;
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

        calendarValidator = new CalendarValidator(calendar);//Server Side validations
        String[] errorMessages = calendarValidator.validateCalendar();//If Server Side validations have errors
        String addModalErrorMessage = "";
        Boolean addSuccess = false;
        message.add("Add Calendar Result");

        //If Errors
        if (errorMessages != null) {
            addModalErrorMessage = errorMessages[0];
        } else { //No Errors
            if (calendarDao.addCalendar(calendar)) {
                addSuccess = true;
            }
        }//Add OK
        if (addSuccess) {
            message.add(String.format("%s added successfully", eventName));
            message.add("success");
            session.setAttribute("message", message);//Show search results with just email to help indicate record on View
            response.sendRedirect("calendar.jsp");
        }//Error from Try/Catch above
        else {
            message.add(addModalErrorMessage);
            message.add("danger");
            session.setAttribute("message", message);
            response.sendRedirect("calendar.jsp");
        }
    }

    private void editCalendar() throws ServletException, IOException {
        Calendar newCalendar = null;
        calendarId = new ObjectId(request.getParameter("calendarIdEdit"));
        try {
            date = format.parse(request.getParameter("dateEdit"));
        } catch (ParseException ex) {
            date = new Date();
        }
        eventName = request.getParameter("eventNameEdit");
        description = request.getParameter("descriptionEdit");
        eventTag = request.getParameter("eventTagEdit");

        newCalendar = new Calendar(calendarId, date, eventName, description, eventTag);

        calendarValidator = new CalendarValidator(newCalendar);
        String[] errorMessages = calendarValidator.validateCalendar();//If Server Side validations have errors
        String editModalErrorMessage = "";
        Boolean editSuccess = false;
        message.add("Edit User Result");

        //If Errors
        if (errorMessages != null) {
            editModalErrorMessage = errorMessages[0];
        } else { //No Errors
            if (calendarDao.editCalendar(newCalendar)) {
                editSuccess = true;
            }
        }//Add OK
        if (editSuccess) {
            message.add(String.format("%s edited successfully", eventName));
            message.add("success");
            session.setAttribute("message", message);//Show search results with just email to help indicate record on View
            response.sendRedirect("calendar.jsp");
        }//Error from Try/Catch above
        else {
            message.add(editModalErrorMessage);
            message.add("danger");
            session.setAttribute("message", message);
            response.sendRedirect("calendar.jsp");
        }
    }

    private void deleteCalendar() throws ServletException, IOException {
        calendarId = new ObjectId(request.getParameter("calendarIdDelete"));
        calendarDao.deleteCalendar(calendarId);
        response.sendRedirect("calendar.jsp");
    }

}
