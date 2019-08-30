<%-- 
    Document   : leave_correct
    Created on : 13/08/2019, 2:20:53 PM
    Author     : MatthewHellmich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Details Correct</title>
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>High School Management System</title>
        
    </head>
    
    <%
        String fname = request.getParameter("fname");
    %>
    
    <body>
        <h3>Your leave form has been successfully uploaded. You'll receive a 
            response within 2 business days.</h3>
        
        <button class="button" type="button" onclick="location.href = 'index.jsp'" > Home </button>
    </body>
</html>
