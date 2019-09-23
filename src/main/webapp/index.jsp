<%-- 
    Document   : index.jsp
    Created on : 10/08/2019, 8:33:10 PM
    Author     : Andrew
    --%>

<%@page import="uts.asd.hsms.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="ConnServlet" flush="true" />
<%@page import="uts.asd.hsms.controller.IndexController"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>High School Management System</title>   
    </head>
    <body>
        <%//Check if there is a valid user in the session
        User user = (User)session.getAttribute("user");
        IndexController controller = new IndexController(session);
        if (user == null) {
            session.setAttribute("redirect", "index");
        %>
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
            int jobsCount = controller.getJobs(null, null, null, null, null, "Open", null, null, true, "_id", 1).length;
        %>   
        <div class="main" role="main">
            <div class="container">
                <h2>Dashboard</h2>
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <div class="box-part text-center">
                                <div class="title">
                                    <h4>Calendar</h4>
                                </div>
                                <div class="text">
                                    <span>You have 1 event coming up.</span>
                                </div>
                                <a href="calendar.jsp">Show More</a>                        
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <div class="box-part text-center">
                                <div class="title">
                                    <h4>News Feed</h4>
                                </div>
                                <div class="text">
                                    <span>There are 3 new posts today.</span>
                                </div>
                                <div>
                                    <a href="newsfeed.jsp">Show More</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <div class="box-part text-center">
                                <div class="title">
                                    <h4>Apply for Leave</h4>
                                </div>
                                <div class="text">
                                    <span>Apply online for Annual Leave, Sick Leave, Maternity Leave or Long Service Leave.</span>
                                </div>
                                <div>
                                    <a href="leaveform.jsp">Show More</a>
                                </div>
                            </div>
                        </div>	
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <div class="box-part text-center">
                                <div class="title">
                                    <h4>Job Board</h4>
                                </div>
                                <div class="text">
                                    <span>Ready for new opportunities?<br><%=jobsCount%> Jobs are waiting for you to apply.</span>
                                </div>
                                <a href="jobboard.jsp">Show More</a>
                            </div>
                        </div>	 
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <div class="box-part text-center">
                                <div class="title">
                                    <h4>HR Feedback</h4>
                                </div>
                                <div class="text">
                                    <span>Your workplace experience is important to us. Send us feedback via HR Feedback.</span>
                                </div>
                                <a href="complaintfill.jsp">Show More</a>
                            </div>
                        </div>	
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <div class="box-part text-center">
                                <div class="title">
                                    <h4>Messages</h4>
                                </div>
                                <div class="text">
                                    <span>You have 2 new Messages.</span>
                                </div>
                                <a href="messages.jsp">Show More</a>
                            </div>
                        </div>
                    </div>	
            </div>
        </div>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
