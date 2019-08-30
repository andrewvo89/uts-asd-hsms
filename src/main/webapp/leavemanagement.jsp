<%-- 
    Document   : leave_management
    Created on : 15/08/2019, 5:25:29 PM
    Author     : MatthewHellmich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leave Management</title>
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>High School Management System</title>
        
    </head>
    <body>
        <h1>Leave Management</h1>
        
        <button class="button" type="button" onclick="location.href = 'index.jsp'" > Home </button>
        
        <table>
            <tr><td><h3>Applications Pending:</h3></td></tr>
            <tr>
                <td><b>Leave ID</b></td><td><b>Name</b></td><td><b>Department</b></td><td><b>Type</b></td><td><b>Date</b></td><td><b>Approve/Deny</b></td></tr><br>
                <tr><td>123456789</td>
                <td>Matthew Smith</td>
                <td>Mathematics</td>
                <td>Annual</td>
                <td>9/1/19 - 15/1/19</td>
                <td><button>Approve</button><button>Deny</button></td>
            </tr><br>
            <tr>
                <td>987654321</td>
                <td>John Jones</td>
                <td>Science</td>
                <td>Sick</td>
                <td>8/6/19 - 8/7/19</td>
                <td><button>Approve</button><button>Deny</button></td>
            </tr><br>
        </table>
        
        
 
        <table>
            <tr><td><h3>Teachers Leave History</h3></td></tr>
            <tr><td><b>Leave ID</b></td><td><b>Name</b></td><td><b>Department</b></td><td><b>Type</b></td><td><b>Date</b></td><td><b>Approved/Denied</b></td></tr><br>
            <tr><td>123456789</td><td>Matthew Smith</td><td>Mathematics</td><td>Annual</td><td>9/1/19 - 15/1/19</td><td>Approved</td></tr><br>
            <tr><td>987654321</td><td>John Jones</td><td>Science</td><td>Sick</td><td>8/6/19 - 8/7/19</td><td>Approved</td></tr><br>
        </table>
        
        <button class="button" type="button" onclick="location.href = 'index.jsp'" > Home </button>
        
    </body>
</html>
