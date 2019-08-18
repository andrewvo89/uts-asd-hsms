<%-- 
    Document   : useradd
    Created on : 18 Aug. 2019, 7:38:57 am
    Author     : Andrew
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%
    UserDao userDao = (UserDao)session.getAttribute("userDao");
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
        <title>User Management</title>
    </head>
    <body>
        <%
            userDao.addUser(request.getParameter("firstName"), request.getParameter("lastName"), request.getParameter("department"), request.getParameter("email"), request.getParameter("password"), Integer.parseInt(request.getParameter("userRole")));
            response.sendRedirect("usermanagement.jsp");
        %>
    </body>
</html>
