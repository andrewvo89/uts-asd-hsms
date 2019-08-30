<%-- 
    Document   : leave_form
    Created on : 13/08/2019, 11:30:19 AM
    Author     : MatthewHellmich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leave Form</title>
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>High School Management System</title>
        
    </head>
    <body>
        <h1>Online Leave Application Form</h1>
        
        <h3>Fill in the details below to apply for a leave of absence.</h3>
        <h3>Management will approve or deny the application within 2 business days.</h3>
        
        <form action="leave_confirmation.jsp" method="post">
            <table>
                <tr><td>First Name:</td><td><input size="23" type="text" name="fname"></td></tr>
                <tr><td>Last Name:</td><td><input size="23" type="text" name="lname"></td></tr>
                <tr><td>Email:</td><td><input size="23" type="text" name="email"></td></tr>
                <tr><td>Leave type:</td><td>
                        <br>
                            <input type="radio" name="ltype" value="annual"> Annual Leave<br>
                            <input type="radio" name="ltype" value="sick"> Sick Leave<br>
                            <input type="radio" name="ltype" value="parental"> Parental Leave<br> 
                            <br>
                </td></tr>
                <tr><td>Leave from:</td><td><input type="date" name="from"></td></tr>
                <tr><td>Leave to:</td><td><input type="date" name="to"></td></tr>
                <tr><td>Teaching department:</td><td> <input type="text" name ="department"></td></tr>
                
                <tr><td></td>
                    <td>
                        <br>
                        <input class="button" type="submit" value="Confirm Details"> 
                        &nbsp; 
                        <button class="button" type="button" onclick="location.href = 'index.jsp'" > Cancel </button>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
