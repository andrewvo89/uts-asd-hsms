<%-- 
    Document   : useradd
    Created on : 18 Aug. 2019, 7:38:57 am
    Author     : Andrew
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%
    UserDao userDao = (UserDao)session.getAttribute("userDao");
    String firstName = request.getParameter("firstNameAdd");
    String lastName = request.getParameter("lastNameAdd");
    String department = request.getParameter("departmentAdd");
    String email = request.getParameter("emailAdd");
    String password = request.getParameter("passwordAdd");
    int userRole = Integer.parseInt(request.getParameter("userRoleAdd"));
%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <%
            userDao.addUser(firstName, lastName, email, password, department, userRole);
            response.sendRedirect("usermanagement.jsp");
        %>
    </body>
</html>
