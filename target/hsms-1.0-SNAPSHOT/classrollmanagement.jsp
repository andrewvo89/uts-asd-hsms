<%-- 
    Document   : rolemanagement
    Created on : 16 Aug. 2019, 7:14:12 pm
    Author     : Griffin
--%>

<%@page import="uts.asd.hsms.controller.*"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="ConnServlet" flush="true" />
<%@page import="uts.asd.hsms.model.*"%>
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
        <%
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "usermanagement");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            TutorialController controllerb = new TutorialController(session);
            //Prefill variable
            Tutorial[] tutorials = controllerb.getTutorials(null, null, null, 0, user.getUserId(), 0, "department", 1);
        %> 
    </head>
    
    <body>
        <div class="main">
            <div class="container">
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Class-roll Management</li>
                    </ol>
                </nav>
                <h1>Class-roll Management</h1>
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
                                for (int x = 0; x < tutorials.length; x++) {
                                    Tutorial currentTutorial = tutorials[x];
                                    ObjectId refId = currentTutorial.getRefId(); 
                                    String tutorialId = currentTutorial.getTutorialId();
                                    String department = currentTutorial.getDepartment();
                                    ObjectId userId = user.getUserId();
                                    int grade = currentTutorial.getGrade();
                                    int tutSize = currentTutorial.getTutSize();  
                            %>
                            <tr>
                                <td><%=tutorialId%></td>
                                <td><%=department%></td>
                                <td><%=grade%></td>
                                <td><%=tutSize%></td>
                                <td>
                                    <form action="classrolledit.jsp" method="post">
                                        <input type="hidden" name="tutorialId" value="<%=tutorialId%>"> 
                                        <button type="submit" class="btn btn-outline-info" id="attendanceEditButton<%=x%>">Edit</button>
                                    </form>
                                </td>
                            <%
                                }
                            %>
                            </tr>
                        </tbody>
                    </table>
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
