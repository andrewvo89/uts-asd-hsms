<%-- 
    Document   : teachermanagement
    Created on : 14 Aug. 2019, 10:58:09 pm
    Author     : Andrew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%
    User user = (User)session.getAttribute("user");
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
        <title>Teacher Management</title>
        <%
        if (user == null) {
            response.sendRedirect("index.jsp?redirect=usermanagement");
        }
        else {
        %>
            <%@ include file="/WEB-INF/jspf/header-loggedin.jspf" %>
        <%
        }
        %>
    </head>
    <body>
        <div class="main">
            <div class="container">
                <h1>User Management</h1>
                <div class="card" style="width: 20rem;">
                    <div class="card-header">
                        <a class="btn btn-secondary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">Search</a>
                    </div>
                    <div class="collapse" id="collapseExample">
                        <div class="card-body">
                            <form>
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstName" placeholder="First Name">
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" placeholder="Last Name">
                                </div>
                                <div class="form-group">
                                    <label for="departmant">Department</label>
                                    <div class="form-check">
                                      <input class="form-check-input" type="radio" name="departmant" id="inlineRadio1" value="All">
                                      <label class="form-check-label" for="inlineRadio1">All</label>
                                    </div>
                                    <div class="form-check">
                                      <input class="form-check-input" type="radio" name="departmant" id="inlineRadio2" value="English">
                                      <label class="form-check-label" for="inlineRadio2">English</label>
                                    </div>
                                    <div class="form-check">
                                      <input class="form-check-input" type="radio" name="departmant" id="inlineRadio3" value="Maths">
                                      <label class="form-check-label" for="inlineRadio3">Maths</label>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary mb-2">Submit</button>
                            </form> 
                     </div>
                    </div>
                </div>         
                <br>                
                <table class="table">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">First Name</th>
                            <th scope="col">Last Name</th>
                            <th scope="col">Department</th>
                            <th scope="col">Email</th>
                            <th scope="col">User Role</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            UserDao userDao = (UserDao)session.getAttribute("userDao");
                            User[] users = userDao.getUsers();
                            for (int x = 0; x < users.length; x++) {
                                User currentUser = users[x];
                        %>
                        <tr>
                            <td><%=currentUser.getFirstName()%></td>
                            <td><%=currentUser.getLastName()%></td>
                            <td><%=currentUser.getDepartment()%></td>
                            <td><%=currentUser.getEmail()%></td>
                            <td><%=currentUser.getUserRoleString()%></td>
                            <td>
                                <button type="button" class="btn btn-primary" onclick="window.location.href = 'useredit.jsp?userId=<%=currentUser.getUserId()%>';">Edit</button>
                                <button type=button" class="btn btn-danger" onclick="window.location.href = 'userdelete.jsp?userId=<%=currentUser.getUserId()%>';">Delete</button>
                            </td>
                        <%
                            }
                        %>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <%@ include file="/WEB-INF/jspf/footer-static.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
