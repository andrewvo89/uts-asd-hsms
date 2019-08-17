<%-- 
    Document   : staffdirectory
    Created on : 2019-8-17, 17:22:24
    Author     : ALVIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%
    User user = (User)session.getAttribute("user");
%>
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
        <title>Staff Directory</title>
                <%
        if (user == null) {
            response.sendRedirect("index.jsp?redirect=jobmanagement");
        }
        else {
        %>
            <%@ include file="/WEB-INF/jspf/header-loggedin.jspf" %>
        <%
        }
        %>

    </head>
    <body>
        <div class="main">
            <div class="container"><br>
                <h1>Staff Directory</h1>
                <h3>Executive</h3>
<p><strong>Alice Lo</strong><br>English<br>Principal<br>Office location CB11.02.011<br>Phone number 0400000000 <br>Email <a href="mailto:principal@hsms.edu.au">principal@hsms.edu.au</a></p>
<h3>Head Teacher</h3>
<p><strong>Bob Smith</strong><br>Science<br>Head Teacher<br>Office location CB11.02.02<br>Phone number 0400000000 <br>Email <a href="mailto:headteacher@hsms.edu.au">headteacher@hsms.edu.au</a></p>

<h3>Teacher</h3>
<p><strong>Joe Blow</strong><br>Art<br>Head Teacher<br>Office location CB11.02.02<br>Phone number 0400000000 <br>Email <a href="mailto:teacher@hsms.edu.au">teacher@hsms.edu.au</a></p>

            </div>
        </div>
        <%@ include file="/WEB-INF/jspf/footer-static.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
