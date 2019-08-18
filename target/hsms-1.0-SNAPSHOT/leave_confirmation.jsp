<%-- 
    Document   : leave_confirmation
    Created on : 13/08/2019, 12:18:12 PM
    Author     : MatthewHellmich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Leave Confirmation</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>High School Management System</title>
        
    </head>
    
    <%
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String ltype = request.getParameter("ltype");
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String department = request.getParameter("department");

        
    %>
    
    <body>
        <h1>Confirm Details</h1>
        <table class="table">
            <tr><td>First Name: </td><td class="text"><%=fname%></td></tr>
            <tr><td>Last Name: </td><td class="text"><%=lname%></td></tr>
            <tr><td>Email: </td><td class="text"><%=email%></td></tr>
            <tr><td>Leave type: </td><td class="text"><%= ltype%></td></tr>
            <tr><td>Leave from: </td><td class="text"><%=from%></td></tr>
            <tr><td>Leave to: </td><td class="text"><%=to%></td></tr>
            <tr><td>Teaching department: </td><td class="text"><%=department%></td></tr>
        </table> 
        <button class="button" type="button" onclick="location.href = 'leave_correct.jsp'" > Details are correct </button>
        &nbsp; 
        <button class="button" type="button" onclick="location.href = 'leave_form.jsp'" > Details not correct </button>
        &nbsp; 
        <button class="button" type="button" onclick="location.href = 'index.jsp'" > Cancel </button>
        
    </body>
</html>
