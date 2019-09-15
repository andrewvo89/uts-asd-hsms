<%-- 
    Document   : classrolledit
    Created on : 16 Aug. 2019, 7:14:43 pm
    Author     : Griffin
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="ConnServlet" flush="true" />
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%@page import="uts.asd.hsms.controller.AttendanceController"%>
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
    </head>
    <body>
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
            AttendanceController controllera = new AttendanceController(session);
            ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
            //Initialise notification messages for errors 1.message header 2.message body 3.message type
        if (message == null) { message = new ArrayList<String>();  message.add(""); message.add(""); message.add(""); }
            
            String tutorialId = new String(request.getParameter("tutorialId"));
            Attendance[] attendances = controllera.getStudentByClass(null, 0, null, null, null, null, null, null, null, null, null, null, null, null, tutorialId, "lastName", 1);
        %> 
        <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>"
        <div class="main">
            <div class="container">
                <h1><%=tutorialId%> Class-roll</h1>
                
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
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int x = 0; x < attendances.length; x++) {
                                        Attendance currentAttendance = attendances[x];
                                        ObjectId refStudentId = currentAttendance.getRefStudentId();
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
                                %>
                                <tr>
                                    <td><%=firstName%></td>
                                    <td><%=lastName%></td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk1" type="text" class="form-control" id="wk1EditField<%=x%>" name="wk1Edit" value="<%=wk1%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk2" type="text" class="form-control" name="wk2Edit" value="<%=wk2%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk3" type="text" class="form-control" name="wk3Edit" value="<%=wk3%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk4" type="text" class="form-control" name="wk4Edit" value="<%=wk4%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk5" type="text" class="form-control" name="wk5Edit" value="<%=wk5%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk6" type="text" class="form-control" name="wk6Edit" value="<%=wk6%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk7" type="text" class="form-control" name="wk7Edit" value="<%=wk7%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk8" type="text" class="form-control" name="wk8Edit" value="<%=wk8%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk9" type="text" class="form-control" name="wk9Edit" value="<%=wk9%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group col-xs-1">
                                            <input for="wk10" type="text" class="form-control" name="wk10Edit" value="<%=wk10%>" maxlength="1">
                                        </div>
                                    </td>
                                    <td>
                                        <input type="hidden" name="postRefStudentId" value="<%=refStudentId%>">
                                        <input type="hidden" name="postStudentId" value="<%=studentId%>">
                                        <input type="hidden"  name="postFirstName" value="<%=firstName%>">
                                        <input type="hidden"  name="postLastName" value="<%=lastName%>">
                                        <input type="hidden" name="postTutorialId" value="<%=tutorialId%>">
                                        <input type="hidden" name="arrayPos" value="<%=x%>"
                                        <input type="hidden" name="action" value="edit">
                                        <button type="submit" class="btn btn-primary" id="attendanceEditConfirmButton<%=x%>">Save</button>
                                    </td>
                    <%
                        }
                    %>
                                </tr>
                            </tbody>
                        </table>
                        <div class="float-right">
                            <a href="classrollmanagement.jsp"><button type="button" class="btn btn-secondary">Close</button></a>
                        </div>
                    </form>            
                                
                            
                </div> 
            </div>
        </div>
        <%
            //Clear error message from Session
            session.removeAttribute("message");
        %>
          
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/classrollmanagement.js"></script>
    </body>
</html>
