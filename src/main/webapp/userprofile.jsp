<%-- 
    Document   : userprofile
    Created on : 17 Aug. 2019, 7:38:38 am
    Author     : Andrew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%
    User user = (User)session.getAttribute("user");
%>
        <%
            if (user == null) {
                response.sendRedirect("index.jsp?redirect=userprofile");
            }
            else {
                String userId = user.getUserIdString();
                String firstName = user.getFirstName();
                String lastName = user.getLastName();
                String email = user.getEmail();
                String password = user.getPassword();
                String department = user.getDepartment();
                int userRole = user.getUserRole();
        %>
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
        <title>User Profile</title>
        <%@ include file="/WEB-INF/jspf/header-loggedin.jspf" %>
    </head>
    <body>
        <div class="main">
            <div class="container" style="width: 750px">
                <h1>User Management</h1>
                <div class="card" style="margin-top:25px">
                    <div class="card-header"></div>
                    <div class="card-body">
                        <form action="useredit.jsp" oninput='passwordConfirm.setCustomValidity(passwordConfirm.value != password.value ? "Passwords do not match." : "")'>
                            <div class="form-group row">
                                <label for="firstName" class="col-sm-4 col-form-label">First Name</label>
                                <div class="col-sm-8 firstName">
                                    <input type="text" class="form-control" name="firstNameEdit" placeholder="First Name" value="<%=firstName%>"disabled="true">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="lastName" class="col-sm-4 col-form-label">Last Name</label>
                                <div class="col-sm-8 lastName">
                                    <input type="text" class="form-control" name="lastNameEdit" placeholder="Last Name" value="<%=lastName%>" disabled="true">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="email" class="col-sm-4 col-form-label">Email</label>
                                <div class="col-sm-8 email">
                                    <input type="email" class="form-control" name="emailEdit" placeholder="Email" value="<%=email%>"  disabled="true">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="password" class="col-sm-4 col-form-label">Password</label>
                                <div class="col-sm-8 password">
                                    <input type="password" class="form-control" name="password" name="passwordEdit"  value="<%=password%>" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="passwordConfirm" class="col-sm-4 col-form-label">Confirm Password</label>
                                <div class="col-sm-8 password">
                                    <input type="password" class="form-control" name="passwordConfirm" name="passwordConfirmEdit"  value="<%=password%>" placeholder="Confirm Password">
                                </div>
                            </div>
                            <div class="hidden">
                                <input type="hidden" name="userIdEdit" value="<%=userId%>">
                                <input type="hidden" name="departmentEdit" value="<%=department%>">
                                <input type="hidden" name="userRoleEdit" value="<%=userRole%>">
                                <input type="hidden" name="redirect" value="userprofile">
                            </div>
                            <div class="float-right">
                                <button type="button" class="btn btn-secondary" onclick="window.location.href='index.jsp'">Close</button>
                                <button type="submit" class="btn btn-primary">Confirm</button>
                            </div>
                    </div>
                </div>
            </div>
        </div>
                <%@ include file="/WEB-INF/jspf/footer-static.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/main.js"></script>

    </body>
        <%
            }
        %>
</html>
