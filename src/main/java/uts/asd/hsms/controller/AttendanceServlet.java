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
import uts.asd.hsms.controller.validator.AttendanceValidator;
import uts.asd.hsms.model.dao.*;
import uts.asd.hsms.model.*;

/**
 *
 * @author Griffin
 */
public class AttendanceServlet extends HttpServlet {
  //  private AttendanceController attendanceController;
    private HttpSession session;
    private AttendanceDao attendanceDao;
    private ArrayList<String> message;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ObjectId refStudentId;
    private String firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId;
    private int studentId, arrayPos;
    private AttendanceValidator attendanceValidator;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        session = request.getSession();
      //  attendanceController = new AttendanceController(session);
        attendanceDao = (AttendanceDao)session.getAttribute("attendanceDao");
        message = new ArrayList<String>();
        this.response = response;
        this.request = request;
        //Processes the post from the classrolledit.jsps 
        //String action = request.getParameter("action");
        //if (action.equals("edit")) editAttendance();
        //else response.sendRedirect("classrolledit.jsp");
        editAttendance();
    }
    /*
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
        
        
    } */
    
    public void editAttendance() throws ServletException, IOException {
        Attendance oldAttendance = null, newAttendance = null;
        refStudentId = new ObjectId(request.getParameter("postRefStudentId"));
        studentId = Integer.parseInt(request.getParameter("postStudentId").trim());
        firstName = request.getParameter("postFirstName").trim();
        lastName = request.getParameter("postLastName").trim();
        wk1 = request.getParameter("wk1Edit").trim();
        wk2 = request.getParameter("wk2Edit").trim();
        wk3 = request.getParameter("wk3Edit").trim();
        wk4 = request.getParameter("wk4Edit").trim();
        wk5 = request.getParameter("wk5Edit").trim();
        wk6 = request.getParameter("wk6Edit").trim();
        wk7 = request.getParameter("wk7Edit").trim();
        wk8 = request.getParameter("wk8Edit").trim();
        wk9 = request.getParameter("wk9Edit").trim();
        wk10 = request.getParameter("wk10Edit").trim();
        tutorialId = request.getParameter("postTutorialId").trim();
        arrayPos = Integer.parseInt(request.getParameter("arrayPos").trim());
       // String editModalErrorMessage = "";
       // Boolean editSuccess = false;
       // message.add("Edit Attendance Result");
        
        /**    if (attendanceDao.getAttendance(refStudentId, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, "lastName", 1)[0] != null) {
                oldAttendance = attendanceDao.getAttendance(refStudentId, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, "lastName", 1)[0];
                newAttendance = new Attendance(refStudentId, studentId, firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId);
                attendanceValidator = new AttendanceValidator(newAttendance);
                String[] errorMessages = attendanceValidator.validateAttendace();
                if (errorMessages != null) editModalErrorMessage = errorMessages[0];
                else {
                    if (attendanceDao.editAttendance(newAttendance)) editSuccess = true;
                    else editModalErrorMessage = "Failed to edit attendance: Database issue";
                }
            } 
            else editModalErrorMessage = "Failed to edit attendance: students don't exist in Database";
            
            if (editSuccess) {
                message.add(String.format("%s edited successfully", newAttendance.getTutorialId())); message.add("success");
            } else {
                message.add(editModalErrorMessage); message.add("danger");
            }
            session.setAttribute("message", message); //Sets success or failure to be displayed
            response.sendRedirect("classrolledit.jsp?postTutorialId=" + tutorialId.toString()); **/
        
            oldAttendance = attendanceDao.getAttendance(refStudentId, 0, null, null, null, null, null, null, null, null, null, null, null, null, null, "lastName", 1)[arrayPos];
            newAttendance = new Attendance(refStudentId, studentId, firstName, lastName, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, tutorialId);
            attendanceDao.editAttendance(newAttendance);
          
        response.sendRedirect("classrolledit.jsp?tutorialId=" + tutorialId.toString());
            
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
