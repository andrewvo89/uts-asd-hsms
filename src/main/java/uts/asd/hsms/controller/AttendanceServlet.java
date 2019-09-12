/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.dao.*;
import uts.asd.hsms.model.*;

/**
 *
 * @author Griffin
 */
public class AttendanceServlet extends HttpServlet {
    private HttpSession session;
    private AttendanceDao attendanceDao;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId refStudentId;
    private String firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId;
    private int studentId;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();
        attendanceDao = (AttendanceDao)session.getAttribute("attendanceDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;
        
        String action = request.getParameter("action");
        if (action.equals("edit")) editAttendance();
        else response.sendRedirect("index.jsp");
    }
    
    public void editAttendance() throws ServletException, IOException {
        wk1 = toProperCase(request.getParameter("wk1Edit"));
        wk2 = toProperCase(request.getParameter("wk2Edit"));
        wk3 = toProperCase(request.getParameter("wk3Edit"));
        wk4 = toProperCase(request.getParameter("wk4Edit"));
        wk5 = toProperCase(request.getParameter("wk5Edit"));
        wk6 = toProperCase(request.getParameter("wk6Edit"));
        wk7 = toProperCase(request.getParameter("wk7Edit"));
        wk8 = toProperCase(request.getParameter("wk8Edit"));
        wk9 = toProperCase(request.getParameter("wk9Edit"));
        wk10 = toProperCase(request.getParameter("wk10Edit"));
        String redirect = request.getParameter("redirect");
        Attendance anAttendance = (Attendance)session.getAttribute("attendance");
        Attendance oldAttendance = null, newAttendance = null;
        
        AttendanceDao sessionAttendance = (AttendanceDao)session.getAttribute("attendanceDao");
     //   sessionAttendance.editAttendance(attendance);
        
        
    }
    
    public String toProperCase(String input) {
        String properCase = "";
        String previousLetter = "";
            for (int x = 0; x < input.length(); x ++) {
                if (x == 0 || previousLetter.equals("-")) properCase += input.substring(x, x + 1).toUpperCase();
                else properCase += input.substring(x, x + 1).toLowerCase();
                previousLetter = input.substring(x, x + 1);
            }
            return properCase;
    }
}
