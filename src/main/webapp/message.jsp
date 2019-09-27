<%-- 
    Document   : message
    Created on : Sep 20, 2019, 6:07:09 PM
    Author     : Sukonrat
--%>

<%@page import="uts.asd.hsms.model.dao.MessageDao"%>
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
        <title>Message</title>
        <%-- //Check if there is a valid user in the session
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "log");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
        --%> 
    </head>
    <body>
        <% 
            
           MessageDao messageDao = (MessageDao)session.getAttribute("messageDao");
           
           %>
        <H3 style="color:#e0ac62; padding-top: 50px;" align="center">User List Contact</H3>
        <table class="table">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">First Name</th>
                            <th scope="col">Last Name</th>
                            <th scope="col">Department</th>
                            <th scope="col">Email</th>
                            <th scope="col">Message</th>
                          
                        </tr>
                    </thead>
                    <tbody>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td> <button type="button">Send Message</button> </td>
                                
                           
                    </tbody>
        </table>
         <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
