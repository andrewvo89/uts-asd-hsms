<%-- 
    Document   : login
    Created on : 14 Aug. 2019, 10:21:13 am
    Author     : Andrew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.*"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>>High School Management System</title>
    </head>
    <body>
        <%
            UserDao userDao = (UserDao)session.getAttribute("userDao");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String redirect = request.getParameter("redirect");
            User user = userDao.getUser(email, password);
            
            if (user != null) {
                session.setAttribute("user", user);
                session.removeAttribute("errorMessage");                    
            } else {
                session.setAttribute("errorMessage", "Username or Password Incorrect");                               
            }
            if (redirect == null || redirect.equals("null")) response.sendRedirect("index.jsp");   
            else response.sendRedirect(redirect + ".jsp");
        %>
        
    </body>
</html>
