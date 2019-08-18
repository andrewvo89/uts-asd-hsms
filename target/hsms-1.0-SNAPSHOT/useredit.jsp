<%-- 
    Document   : useredit
    Created on : 18 Aug. 2019, 12:04:19 pm
    Author     : Andrew
--%>
<%@page import="org.bson.types.ObjectId"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%
    UserDao userDao = (UserDao)session.getAttribute("userDao");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            userDao.editUser(new ObjectId(request.getParameter("userId")), request.getParameter("firstName"), request.getParameter("lastName"), request.getParameter("department"), request.getParameter("email"), request.getParameter("password"), Integer.parseInt(request.getParameter("userRole")));
            response.sendRedirect("usermanagement.jsp");
        %>
    </body>
</html>
