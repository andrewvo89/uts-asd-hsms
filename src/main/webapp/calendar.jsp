<%-- 
    Document   : calendar
    Created on : 23/09/2019, 2:19:30 PM
    Author     : MatthewHellmich
--%>

<%@page import="uts.asd.hsms.model.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.controller.*"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">

        <title>Calendar</title>


    </head>
    <body>
        <div class="container">
        <h2>Calendar</h2>
        <!--POPULATE TABLE WITH SEARCH RESULTS-->
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th scope="col">Date</th>
                    <th scope="col">Event Name</th>
                    <th scope="col">Description</th>
                    <th scope="col">Event Tag</th>
                </tr>
            </thead>
            <tbody>
                <%
                    //Loop through results of MongoDB search result and place them in a table
//                    for (int i = 0; i < calendars.length; i++) {
//                        Calendar currentCalendar = calendars[i];
//                        ObjectId calendarId = currentCalendar.getCalendarId();
//                        Date date = currentCalendar.getDate();
//                        String eventName = currentCalendar.getEventName();
//                        String description = currentCalendar.getDescription();
//                        String eventTag = currentCalendar.getEventTag();
                %>
               
            </tbody>
        </table>
        </div>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>