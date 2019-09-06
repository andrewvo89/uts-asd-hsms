<%-- 
    Document   : classrolledit
    Created on : 16 Aug. 2019, 7:14:43 pm
    Author     : Griffin
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%@page import="uts.asd.hsms.controller.*"%>
<%@page import="java.io.*,java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
<%@page import="javax.activation.*,javax.mail.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>Edit Class Roll</title>
        <%
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "classrolledit");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            
        %> 
    </head>
    <body>
        <div class="main">
            <div class="container">
                <h1>Class-roll Edit</h1>
                
                <br><div>
                    <form action="AttendanceServlet" method="post">
                        <table class="table">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col">First Name</th>
                                    <th scope="col">Last Name</th>
                                    <th scope="col">Wk 1</th>
                                    <th scope="col">Wk 2</th>
                                    <th scope="col">Wk 3</th>
                                    <th scope="col">Wk 4</th>
                                    <th scope="col">Wk 5</th>
                                    <th scope="col">Wk 6</th>
                                    <th scope="col">Wk 7</th>
                                    <th scope="col">Wk 8</th>
                                    <th scope="col">Wk 9</th>
                                    <th scope="col">Wk 10</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        AttendanceDao attendanceDao = (AttendanceDao)session.getAttribute("attendanceDao");
                                        Attendance[] attendance = attendanceDao.getAttendance();
                                        for (int x = 0; x < attendance.length; x++) {
                                        Attendance currentAttendance = attendance[x];
                                        int studentId = currentAttendance.getStudentId(); 
                                        String firstName = currentAttendance.getFirstName();
                                        String lastName = currentAttendance.getLastName();
                                        String wk1 = currentAttendance.getWk1();
                                        String wk2 = currentAttendance.getWk2();
                                        String wk3 = currentAttendance.getWk3();
                                        String wk4 = currentAttendance.getWk4();
                                        String wk5 = currentAttendance.getWk5();
                                        String wk6 = currentAttendance.getWk6();
                                        String wk7 = currentAttendance.getWk7();
                                        String wk8 = currentAttendance.getWk8();
                                        String wk9 = currentAttendance.getWk9();
                                        String wk10 = currentAttendance.getWk10();
                                        String tutorialId = currentAttendance.getTutorialId();
                                                                        %>
                                <tr>
                                    <td name="firstName"><%=firstName%></td>
                                    <td name="lastName"><%=lastName%></td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk1" type="text" class="form-control" name="wk1Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk2" type="text" class="form-control" name="wk2Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk3" type="text" class="form-control" name="wk3Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk4" type="text" class="form-control" name="wk4Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk5" type="text" class="form-control" name="wk5Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk6" type="text" class="form-control" name="wk6Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk7" type="text" class="form-control" name="wk7Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk8" type="text" class="form-control" name="wk8Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk9" type="text" class="form-control" name="wk9Edit" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk10" type="text" class="form-control" name="wk10Edit" maxlength="1">
                                        </div>
                                    </td>

                    <%
                        }
                    %>
                                </tr>
                            </tbody>
                        </table>
                        <div class="float-right">
                            <input type="hidden" name="action" value="edit">
                            <button type="submit" class="btn btn-success">Save</button>
                        </div>
                        <div class="float-right">
                            <a href="classrollmanagement.jsp"><button type="button" class="btn btn-secondary">Cancel</button></a>
                        </div>
                    </form>            
                                
                            
                </div> 
            </div>
        </div>
          
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/classrollmanagement.js"></script>
    </body>
</html>
