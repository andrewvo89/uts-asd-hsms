<%-- 
    Document   : userprofile
    Created on : 17 Aug. 2019, 7:38:38 am
    Author     : Andrew
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
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
        <%
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "userprofile");
        %>    
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
        %> 
    </head>
    <%        
        ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        if (message == null) {
            message = new ArrayList<String>();
            message.add(""); message.add(""); message.add("");
        }
            String userId = user.getUserIdString();
            String firstName = user.getFirstName();
            String lastName = user.getLastName();
            String email = user.getEmail();
            String department = user.getDepartment();
            int userRole = user.getUserRole();
    %>
    <body>
        <div class="main">
            <div class="container" style="width: 750px">
                <h1>Edit Profile</h1>
                <div class="card" style="margin-top:25px">
                    <div class="card-header"></div>
                    <div class="card-body">
                        <form action="UserServlet" method="post" oninput='passwordConfirmEdit.setCustomValidity(passwordConfirmEdit.value != passwordEdit.value ? "Passwords do not match." : "")'>
                            <div class="form-group row">
                                <label for="firstName" class="col-sm-4 col-form-label">First Name</label>
                                <div class="col-sm-8 firstName">
                                    <input type="text" class="form-control" name="firstName" placeholder="First Name" value="<%=firstName%>" disabled="true">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="lastName" class="col-sm-4 col-form-label">Last Name</label>
                                <div class="col-sm-8 lastName">
                                    <input type="text" class="form-control" name="lastName" placeholder="Last Name" value="<%=lastName%>" disabled="true">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="email" class="col-sm-4 col-form-label">Email</label>
                                <div class="col-sm-8 email">
                                    <input type="email" class="form-control" name="email" placeholder="Email" value="<%=email%>"  disabled="true">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="passwordEdit" class="col-sm-4 col-form-label">Password</label>
                                <div class="col-sm-8 password">
                                    <div class="input-group" id="show_hide_password">
                                        <input type="password" class="form-control pwd1" name="passwordEdit" placeholder="New Password" minlength="6" maxlength="16" required>
                                        <button class="btn btn-outline-dark reveal1" type="button" data-toggle="button">show</button> 
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="passwordConfirmEdit" class="col-sm-4 col-form-label">Confirm Password</label>
                                <div class="col-sm-8 password">
                                     <div class="input-group" id="show_hide_password">
                                        <input type="password" class="form-control pwd2" name="passwordConfirmEdit" placeholder="Confirm Password" minlength="6" maxlength="16" required>
                                        <button class="btn btn-outline-dark reveal2" type="button" data-toggle="button">show</button> 
                                    </div>
                                </div>
                            </div>
                            <div class="hidden">
                                <input type="hidden" name="userIdEdit" value="<%=userId%>">
                                <input type="hidden" name="firstNameEdit" value="<%=firstName%>">
                                <input type="hidden" name="lastNameEdit" value="<%=lastName%>">
                                <input type="hidden" name="emailEdit" value="<%=email%>">
                                <input type="hidden" name="departmentEdit" value="<%=department%>">
                                <input type="hidden" name="userRoleEdit" value="<%=userRole%>">
                                <input type="hidden" name="redirect" value="userprofile">
                                <input type="hidden" name="action" value="edit">
                            </div>     
                            <div class="alert alert-<%=message.get(2)%> mr-auto" role="alert" style="text-align: center"><%=message.get(1)%></div>
                            <div class="float-right">   
                                <input type="hidden" name="action" value="edit">                               
                                <button type="button" class="btn btn-secondary" onclick="window.location.href='index.jsp'">Close</button>
                                <button type="submit" class="btn btn-primary">Confirm</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%                            
            session.removeAttribute("message");
            session.removeAttribute("modalTrigger");
        %>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/userprofile.js"></script>
    </body>
</html>
