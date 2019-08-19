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
    User user = (User)session.getAttribute("user");
    UserDao userDao = (UserDao)session.getAttribute("userDao");
    ObjectId userId = new ObjectId(request.getParameter("userIdEdit"));
    String firstName = request.getParameter("firstNameEdit");
    String lastName = request.getParameter("lastNameEdit");
    String department = request.getParameter("departmentEdit");
    String email = request.getParameter("emailEdit");
    String password = request.getParameter("passwordEdit");
    int userRole = Integer.parseInt(request.getParameter("userRoleEdit"));
    String redirect = request.getParameter("redirect");    
%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <%
            userDao.editUser(userId, firstName, lastName, email, password, department, userRole);
            if (userId.equals(user.getUserId())) {
                session.setAttribute("user", new User(userId, firstName, lastName, email, password, department, userRole));
            }
            response.sendRedirect(redirect + ".jsp");
        %>
    </body>
</html>
