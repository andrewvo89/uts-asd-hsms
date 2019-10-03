<%-- 
    Document   : leave_form
    Created on : 13/08/2019, 11:30:19 AM
    Author     : MatthewHellmich
--%>

<%@page import="uts.asd.hsms.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leave Form</title>        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>Leave Form</title>        
    </head>
    <body>
        <%//Check if there is a valid user in the session
        User user = (User)session.getAttribute("user");
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
        %>
        <div class="main" role="main">
        <div class="container">
            
        <h1>Online Leave Application Form</h1>
        
        <h3>Fill in the details below to apply for a leave of absence.</h3>
        
        <form action="leaveconfirmation.jsp" method="post">
            <table>
                <tr><td>First Name:</td><td><input size="23" type="text" name="fname"></td></tr>
                <tr><td>Last Name:</td><td><input size="23" type="text" name="lname"></td></tr>
                <tr><td>Email:</td><td><input size="23" type="text" name="email"></td></tr>
                <tr><td>Leave type:</td><td>
                        <br>
                            <input type="radio" name="ltype" value="annual"> Annual Leave<br>
                            <input type="radio" name="ltype" value="sick"> Sick Leave<br>
                            <input type="radio" name="ltype" value="parental"> Parental Leave<br> 
                            <br>
                </td></tr>
                <tr><td>Leave from:</td><td><input type="date" name="from"></td></tr>
                <tr><td>Leave to:</td><td><input type="date" name="to"></td></tr>
                <tr><td>Teaching department:</td><td> <input type="text" name ="department"></td></tr>
                
                <tr><td></td>
                    <td>
                        <br>
                        <input class="button" type="submit" value="Confirm Details"> 
                        &nbsp; 
                        <button class="button" type="button" onclick="location.href = 'index.jsp'" > Cancel </button>
                    </td>
                </tr>
            </table>
        </form>
        </div>
        </div>
         <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>  
    </body>
</html>

