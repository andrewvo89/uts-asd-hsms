<%-- 
    Document   : rolemanagement
    Created on : 16 Aug. 2019, 7:14:12 pm
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
        <title>Class Roll Management</title>
        
    </head>
    
    <body>
        <div class="main">
            <div class="container">
                <h1>Class-roll Management</h1>
                
                <!-- Div for filter section -->
                <div class="card" style="margin-top:25px">
                    <div class="card-header">
                        <button type="button" class="btn btn-secondary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample" data-toggle="button">Filter</button>
                    </div>
                    <div class="collapse" id="collapseExample">
                        <div class="card-body">
                            <form action="">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="firstName">Class ID</label>
                                    <input type="text" class="form-control" id="classId" placeholder="Class ID">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lastName">Department</label>
                                    <input type="text" class="form-control" id="department" placeholder="Department">
                                </div>
                            </div>
                                <div class="form-row">
                                    <div class="form-group col-md-7">
                                        <label for="departmentSearch">Grade</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="all" value="all" checked>
                                                <label class="form-check-label" for="all">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="7" value="7">
                                                <label class="form-check-label" for="7">7</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="8" value="8">
                                                <label class="form-check-label" for="8">8</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="9" value="9">
                                                <label class="form-check-label" for="9">9</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="10" value="10">
                                                <label class="form-check-label" for="10">10</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="11" value="11">
                                                <label class="form-check-label" for="11">11</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="12" value="12">
                                                <label class="form-check-label" for="12">12</label>
                                            </div> 
                                        </div>
                                    </div>
                                </div> 
                                <button type="submit" class="btn btn-primary mb-2">Search</button>
                            </form> 
                     </div>
                    </div>
                </div>
                
                    <br><table class="table table-hover" id="tutTable">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">Class ID</th>
                                <th scope="col">Department</th>
                                <th scope="col">Grade</th>
                                <th scope="col">Class Size</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody> 
                            <%
                                TutorialDao tutorialDao = (TutorialDao)session.getAttribute("tutorialDao");
                                Tutorial[] tutorials = tutorialDao.getTutorials();
                                for (int x = 0; x < tutorials.length; x++) {
                                    Tutorial currentTut = tutorials[x];
                                    String refId = currentTut.getRefIdString(); 
                                    String tutorialId = currentTut.getTutorialId();
                                    String department = currentTut.getDepartment();
                                    int grade = currentTut.getGrade();
                                    String userId = currentTut.getUserIdString();
                                    int tutSize = currentTut.getTutSize();  
                            %>
                            <tr>
                                <td><%=tutorialId%></td>
                                <td><%=department%></td>
                                <td><%=grade%></td>
                                <td><%=tutSize%></td>
                                <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editRollModal" role="button" data-tutorial-id="<%=tutorialId%>">Edit</button>         
                                </td>
                            <%
                                }
                            %>
                            </tr> 
                        <button type="button" class="btn btn-primary"><a  href="classrolledit.jsp">Test</a></button>
                        </tbody>
                    </table>
            </div>   
            
            
            <!--Div for roll edit -->
            <div class="modal fade" id="editRollModal" tabindex="-1" role="dialog" aria-labelledby="editRoll" aria-hidden="true">
                
                                    <div class="modal-dialog modal-lg" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editRollModalLabel"></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="">
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
                                                                <td><%=firstName%></td>
                                                                <td><%=lastName%></td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk1" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk2" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk3" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk4" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk5" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk6" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk7" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk8" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk9" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <div class="col-xs-1">
                                                                        <input for="wk1" type="text" class="form-control" name="wk10" maxlength="1">
                                                                    </div>
                                                                </td>
                                                                
                                                <%
                                                    }
                                                %>
                                                            </tr>
                                                            
                                                        </tbody>
                                                    </table>
                                                            
                                                    <div class="modal-footer">
                                                        <input type="hidden" name="action" value="edit">
                                                        <input type="hidden" name="redirect" value="classrollmanagement">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary">Confirm</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
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
