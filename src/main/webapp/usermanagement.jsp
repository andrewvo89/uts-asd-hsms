<%-- 
    Document   : usermanagement
    Created on : 14 Aug. 2019, 10:58:09 pm
    Author     : Andrew1
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
        <title>User Management</title>
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
                <div class="card">
                    <div class="card-header">
                        <button type="button" class="btn btn-secondary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample" data-toggle="button">Filter</button>
                    </div>
                    <div class="collapse" id="collapseExample">
                        <div class="card-body">
                            <form action="" oninput='passwordConfirm.setCustomValidity(passwordConfirm.value != password.value ? "Passwords do not match." : "")'>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstName" placeholder="First Name">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" placeholder="Last Name">
                                </div>
                            </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="departmentSearch">Department</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="all" value="all" checked>
                                                <label class="form-check-label" for="all">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="english" value="english">
                                                <label class="form-check-label" for="english">English</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="math" value="math">
                                                <label class="form-check-label" for="math">Maths</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="science" value="science">
                                                <label class="form-check-label" for="science">Science</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="art" value="art">
                                                <label class="form-check-label" for="art">Art</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="music" value="music">
                                                <label class="form-check-label" for="music">Music</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="departmant">Permission Level</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="permissionSearch" id="all" value="all" checked>
                                                <label class="form-check-label" for="all">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="permissionSearch" id="administrator" value="administrator">
                                                <label class="form-check-label" for="administrator">Administrator</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="permissionSearch" id="principal" value="principal">
                                                <label class="form-check-label" for="principal">Principal</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="permissionSearch" id="headTeacher" value="headTeacher">
                                                <label class="form-check-label" for="headTeacher">Head Teacher</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="permissionSearch" id="teacher" value="teacher">
                                                <label class="form-check-label" for="teacher">Teacher</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                </div> 
                                <button type="submit" class="btn btn-primary mb-2">Search</button>
                            </form> 
                     </div>
                    </div>
                </div>
                
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
                                int userId = currentUser.getUserId();
                                String firstName = currentUser.getFirstName();
                                String lastName = currentUser.getLastName();
                                String department = currentUser.getDepartment();
                                String email = currentUser.getEmail();
                                String password = currentUser.getPassword();
                                String userRoleString = currentUser.getUserRoleString();
                        %>
                        <tr>
                            <td><%=firstName%></td>
                            <td><%=lastName%></td>
                            <td><%=department%></td>
                            <td><%=email%></td>
                            <td><%=userRoleString%></td>
                            <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#userEditModal" role="button" 
                                        data-userid="<%=userId%>" data-firstname="<%=firstName%>" data-lastname="<%=lastName%>"
                                        data-department="<%=department%>" data-email="<%=email%>" data-password="<%=password%>" 
                                        data-userrolestring="<%=userRoleString%>">Edit</button>
                                        
                                <div class="modal fade" id="userEditModal" tabindex="-1" role="dialog" aria-labelledby="userEditModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="userEditModalLabel"></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="" oninput='passwordConfirm.setCustomValidity(passwordConfirm.value != password.value ? "Passwords do not match." : "")'>
                                                    <div class="form-group row">
                                                        <label for="firstName" class="col-sm-4 col-form-label">First Name</label>
                                                        <div class="col-sm-8 firstName">
                                                            <input type="text" class="form-control" id="firstName" placeholder="First Name">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="lastName" class="col-sm-4 col-form-label">Last Name</label>
                                                        <div class="col-sm-8 lastName">
                                                            <input type="text" class="form-control" id="lastName" placeholder="Last Name">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="email" class="col-sm-4 col-form-label">Email</label>
                                                        <div class="col-sm-8 email">
                                                            <input type="email" class="form-control" id="email" placeholder="Email">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="password" class="col-sm-4 col-form-label">Password</label>
                                                        <div class="col-sm-8 password">
                                                            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="passwordConfirm" class="col-sm-4 col-form-label">Confirm Password</label>
                                                        <div class="col-sm-8 password">
                                                            <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm Password">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-4">Department</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentAdd" id="English">
                                                                <label class="form-check-label" for="english">English</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Math">
                                                                <label class="form-check-label" for="math">Math</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Science">
                                                                <label class="form-check-label" for="science">Science</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Art">
                                                                <label class="form-check-label" for="art">Art</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Music">
                                                                <label class="form-check-label" for="department">Music</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <legend class="col-form-label col-sm-4 pt-0">User Role</legend>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Administrator">
                                                                <label class="form-check-label" for="administrator">Administrator</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Principal">
                                                                <label class="form-check-label" for="principal">Principal</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Head Teacher">
                                                                <label class="form-check-label" for="headTeacher">Head Teacher</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Teacher">
                                                                <label class="form-check-label" for="teacher">Teacher</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="userId">
                                                        <input type="hidden" id="userId">
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-8">
                                                            <button type="submit" class="btn btn-primary">Confirm</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <button type=button" class="btn btn-danger" onclick="window.location.href = 'userdelete.jsp?userId=<%=currentUser.getUserId()%>';">Delete</button>
                            </td>
                        <%
                            }
                        %>
                        </tr>
                    </tbody>
                </table>
                <div class="float-right">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#userAddModal" role="button">Add User</button>
                </div>
   
                <div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="userAddModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="userAddModalLabel">Add User</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="" oninput='passwordConfirm.setCustomValidity(passwordConfirm.value != password.value ? "Passwords do not match." : "")'>
                                    <div class="form-group row">
                                        <label for="firstName" class="col-sm-4 col-form-label">First Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="firstName" placeholder="First Name">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="lastName" class="col-sm-4 col-form-label">Last Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="lastName" placeholder="Last Name">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="email" class="col-sm-4 col-form-label">Email</label>
                                        <div class="col-sm-8 email">
                                            <input type="email" class="form-control" id="email" placeholder="Email">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="password" class="col-sm-4 col-form-label">Password*</label>
                                        <div class="col-sm-8">
                                            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="passwordConfirm" class="col-sm-4 col-form-label">Confirm Password*</label>
                                        <div class="col-sm-8">
                                            <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" placeholder="Confirm Password">
                                        </div>
                                    </div>
                            <div class="form-group row">
                                <div class="col-sm-4">Department</div>
                                <div class="col-sm-8">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="departmentAdd" id="English" checked>
                                        <label class="form-check-label" for="english">English</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="departmentAdd" id="Math">
                                        <label class="form-check-label" for="math">Math</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="departmentAdd" id="Science">
                                        <label class="form-check-label" for="science">Science</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="departmentAdd" id="Art">
                                        <label class="form-check-label" for="art">Art</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="departmentAdd" id="Music">
                                        <label class="form-check-label" for="department">Music</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <legend class="col-form-label col-sm-4 pt-0">User Role</legend>
                                <div class="col-sm-8">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="userRoleAdd" id="Administrator" checked>
                                        <label class="form-check-label" for="administrator">Administrator</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="userRoleAdd" id="Principal">
                                        <label class="form-check-label" for="principal">Principal</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="userRoleAdd" id="Head Teacher">
                                        <label class="form-check-label" for="headTeacher">Head Teacher</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="userRoleAdd" id="Teacher">
                                        <label class="form-check-label" for="teacher">Teacher</label>
                                    </div>
                                </div>
                            </div>
                                    <div class="form-group row">
                                        <div class="col-sm-12">
                                            <button type="submit" class="btn btn-primary float-right">Confirm</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
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
</html>
