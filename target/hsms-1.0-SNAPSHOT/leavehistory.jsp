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
        
        <div class="container">
        <h1>Leave Applications</h1>
        
        <h3>Apply for leave: <button class="button" type="button" onclick="location.href = 'leaveform.jsp'" > Apply </button></h3>
                
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
    </div>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        
    </body>
</html>

