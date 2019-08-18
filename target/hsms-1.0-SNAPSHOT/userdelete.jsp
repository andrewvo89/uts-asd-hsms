<%-- 
    Document   : userdelete
    Created on : 18 Aug. 2019, 9:00:40 am
    Author     : Andrew
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%
    UserDao userDao = (UserDao)session.getAttribute("userDao");
    ObjectId userId = new ObjectId(request.getParameter("userIdDelete"));
%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <%
            userDao.deleteUser(userId);
            response.sendRedirect("usermanagement.jsp");
        %>
    </body>
</html>

