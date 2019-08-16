<%-- 
    Document   : leave_history
    Created on : 13/08/2019, 7:56:18 PM
    Author     : MatthewHellmich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leave Applications</title>
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>High School Management System</title>
        
    </head>
    <body>
        <h1>Leave Applications</h1>
        
        <h3>Apply for leave: <button class="button" type="button" onclick="location.href = 'leave_form.jsp'" > Apply </button></h3>
                
        <table>
            <tr><td><h3>Applications Pending:</h3></td></tr>
            <tr><td><b>Type</b></td><td><b>Date</b></td></tr><br>
            <tr><td>Annual</td><td>9/1/19 - 15/1/19</td></tr><br>
            <tr><td>Sick</td><td>8/6/19 - 8/7/19</td></tr><br>
        </table>
        <table>
            <tr><td><h3>Application's Approved:</h3></td></tr>
            <tr><td><b>Type</b></td><td><b>Date</b></td></tr><br>
            <tr><td>Annual</td><td>9/1/19 - 15/1/19</td></tr><br>
            <tr><td>Sick</td><td>8/6/19 - 8/7/19</td></tr><br>
        </table>
        <table>
            <tr><td><h3>Application's Denied:</h3></td></tr>
            <tr><td><b>Type</b></td><td><b>Date</b></td></tr><br>
            <tr><td>Annual</td><td>9/1/19 - 15/1/19</td></tr><br>
            <tr><td>Sick</td><td>8/6/19 - 8/7/19</td></tr><br>
        </table>
        <table>
            <tr><td><h3>Past Leave's:</h3></td></tr>
            <tr><td><b>Type</b></td><td><b>Date</b></td><td><b>Approved/Denied</b></td></tr><br>
            <tr><td>Annual</td><td>9/1/19 - 15/1/19</td><td>Approved</td></tr><br>
            <tr><td>Sick</td><td>8/6/19 - 8/7/19</td><td>Approved</td></tr><br>
        </table>
        <br>
        <button class="button" type="button" onclick="location.href = 'index.jsp'" > Home </button>
    </body>
</html>
