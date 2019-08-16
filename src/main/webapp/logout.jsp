<%-- 
    Document   : logout
    Created on : 14 Aug. 2019, 11:13:14 am
    Author     : Andrew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>>High School Management System</title>
    </head>
    <body>
        <%
            session.invalidate();
            response.sendRedirect("index.jsp"); 
        %>
    </body>
</html>
