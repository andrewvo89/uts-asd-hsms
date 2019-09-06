<%-- 
    Document   : searchLog
    Created on : Aug 16, 2019, 10:36:38 PM
    Author     : Sukonrat
--%>

<%@page import="uts.asd.hsms.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/ConnServlet" flush="true" />
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

        <%--
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
        --%>      
    </head>
    <body>
       <H3 style="color:#e0ac62; padding-top: 150px;" align="center">Search Log Activities</H3>
<table style="padding-top: 150px;" width="600" border="1" align="center">
<tr>
<th> <div align="center">Date </div></th>
<th> <div align="center">UserID</div></th>
<th> <div align="center">FirstName</div></th>
</tr>

<tr>
<td><div align="center" value="${userAudit.timeStamp}"></div></td>
<td><div align="center" value="${userAudit.userID}"></div></td>
<td><div align="center" value="${userAudit.firtName}"></div></td>
</tr>
</table>  
        
         <%--@ include file="/WEB-INF/jspf/footer-static.jspf" --%>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>

