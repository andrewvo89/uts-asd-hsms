<%-- 
    Document   : index.jsp
    Created on : 10/08/2019, 8:33:10 PM
    Author     : Andrew1
--%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/ConnServlet" flush="true" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>High School Management System</title>

        <%
        User user = (User) session.getAttribute("user");
        String submitted = request.getParameter("submitted");
        if (submitted == null) {%>
            <%@ include file="/WEB-INF/jspf/header-loggedout.jspf" %><%
        }
        else {%>
            <%@ include file="/WEB-INF/jspf/header-loggedin.jspf" %><%
        }
        %>      
    </head>

    <body>
        <%    
        if (submitted == null) {%>
            <form class="form-signin" method="post" action="index.jsp">
                <h1 class="h3 mb-3 font-weight-normal">Sign In</h1>
                <label for="inputId" class="sr-only">Email address</label>
                <input name="username" type="text" id="inputId" class="form-control" placeholder="teacher@hsms.com.au" required autofocus>
                <label for="inputPassword" class="sr-only">Password</label>
                <input name="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                <input type="hidden" name="submitted" value="yes">
            </form><%
        }
        else {%>
            <div class="container">
                    <h1 class="h3 mb-3 font-weight-normal">Logged in Successfully</h1>
            </div><%
        }%>

                
            <%@ include file="/WEB-INF/jspf/footer-static.jspf" %>


        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
