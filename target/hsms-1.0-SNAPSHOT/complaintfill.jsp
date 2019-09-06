<%-- 
    Document   : complaintfill
    Created on : 16 Aug. 2019, 7:15:24 pm
    Author     : Griffin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
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
        <title>Submit Complaint</title>
        <%
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "usermanagement");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
                if (user.getUserRole() > 2) response.sendRedirect("index.jsp");
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
        %> 
    </head>
    <body>
        <div class="main">
            <div class="container">
                <h1>Submit Feedback</h1><br>
                <form>
                    <p>Here at High School Management High School, we are dedicated to ensuring the happiness of both our students and our staff. For this reason, we are always looking
                        for ways to improve all aspects of the school.<br>
                        If you have any issues, feedback, information, or thoughts that you feel can help better, please leave a comment below, and Susan in the admin office will escalate the comment appropriately. <br>
                        Remember, all your information is private. This is an <b>anonymous</b> feedback service, and the author of any comments cannot be traced.</p>
                    <div class="form-group">
                        <label for="sell"><b>Subject header:</b></label>
                        <select class="form-control" id="sell">
                            <option>Facilities</option>
                            <option>Management</option>
                            <option>Student Issues</option>
                            <option>Harassment</option>
                            <option>Discrimination</option>
                            <option value="6">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="other"><b>Other: </b></label>
                        <textarea class="form-control" rows="1" id="other"></textarea>
                        </div>
                    <div class="form-group">
                        <label for="comment"><b>Comment:</b></label>
                        <textarea class="form-control" rows="5" id="comment"></textarea>
                    </div>
                <button type="submit" class="btn btn-default">Submit</button>
                </form>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/usermanagement.js"></script>
    </body>
</html>
