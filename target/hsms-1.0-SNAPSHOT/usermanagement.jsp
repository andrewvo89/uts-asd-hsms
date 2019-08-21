<%-- 
    Document   : usermanagement
    Created on : 14 Aug. 2019, 10:58:09 pm
    Author     : Andrew
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%@page import="uts.asd.hsms.controller.*"%>
<%@page import="java.io.*,java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
<%@page import="javax.activation.*,javax.mail.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.util.ArrayList"%>
        
<%
    User user = (User)session.getAttribute("user");
    UserDao userDao = (UserDao)session.getAttribute("userDao");
    ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
    if (message == null) {
        message = new ArrayList<String>();//1.message header 2.message body 3.message type 4.modal trigger
        message.add(""); message.add(""); message.add(""); message.add("");
    }
    //Prefill Add Data variables    
    String firstNameAdd = (String)session.getAttribute("firstNameAdd");
    String lastNameAdd = (String)session.getAttribute("lastNameAdd");
    String emailAdd = (String)session.getAttribute("emailAdd");
    String passwordAdd = (String)session.getAttribute("passwordAdd");
    String departmentAdd = (String)session.getAttribute("departmentAdd");
    String depratmentAddEnglish = "", depratmentAddMath = "", depratmentAddScience = "", depratmentAddArt = "", depratmentAddMusic = "";
    String userRoleAddAdministrator = "", userRoleAddPrincipal = "", userRoleAddHeadTeacher = "", userRoleAddTeacher = "";
    int userRoleAdd = 0;  
    if (session.getAttribute("userRoleAdd") != null) {
        try {
            userRoleAdd = Integer.valueOf((session.getAttribute("userRoleAdd").toString()));
        }
        catch (NumberFormatException ex) {
            userRoleAdd = 0;
        }
    }    
    if (firstNameAdd == null) firstNameAdd = "";
    if (lastNameAdd == null) lastNameAdd = "";
    if (emailAdd == null) emailAdd = "";
    if (passwordAdd == null) passwordAdd = "";
    if (departmentAdd == null) departmentAdd = "";
    if (departmentAdd.equals("Math")) depratmentAddMath = "checked";
    else if(departmentAdd.equals("Science")) depratmentAddScience = "checked";
    else if(departmentAdd.equals("Art")) depratmentAddArt = "checked";
    else if(departmentAdd.equals("Music")) depratmentAddMusic = "checked";
    else depratmentAddEnglish = "checked";
    if(userRoleAdd == 2) userRoleAddPrincipal = "checked";
    else if(userRoleAdd == 3) userRoleAddHeadTeacher = "checked";
    else if(userRoleAdd == 4) userRoleAddTeacher = "checked";
    else userRoleAddAdministrator = "checked";

    //Prefill Search Data variables
    String firstNameSearch = request.getParameter("firstNameSearch");
    String lastNameSearch = request.getParameter("lastNameSearch");
    String departmentSearch = request.getParameter("departmentSearch");
    String emailSearch = request.getParameter("emailSearch");
    String departmentSearchAll="", departmentSearchEnglish="", departmentSearchMath="", departmentSearchScience="", departmentSearchArt="", departmentSearchMusic="";
    String userRoleSearchAll="", userRoleSearchAdministrator="", userRoleSearchPrincipal="", userRoleSearchHeadTeacher="", userRoleSearchTeacher="";
    int userRoleSearch = 0;    
    if (request.getParameter("userRoleSearch") != null) {
        try {
            userRoleSearch = Integer.parseInt(request.getParameter("userRoleSearch"));
        }
        catch (NumberFormatException ex) {
            userRoleSearch = 0;
        }
    }
    if (firstNameSearch == null) firstNameSearch = "";
    if (lastNameSearch == null) lastNameSearch = "";
    if (departmentSearch == null) departmentSearch = "";
    if (emailSearch == null) emailSearch = "";    
    if (departmentSearch.equals("English")) departmentSearchEnglish = "checked";
    else if(departmentSearch.equals("Math")) departmentSearchMath = "checked";
    else if(departmentSearch.equals("Science")) departmentSearchScience = "checked";
    else if(departmentSearch.equals("Art")) departmentSearchArt = "checked";
    else if(departmentSearch.equals("Music")) departmentSearchMusic = "checked";
    else departmentSearchAll = "checked";    
    if (userRoleSearch == 1) userRoleSearchAdministrator = "checked";
    else if(userRoleSearch == 2) userRoleSearchPrincipal = "checked";
    else if(userRoleSearch == 3) userRoleSearchHeadTeacher = "checked";
    else if(userRoleSearch == 4) userRoleSearchTeacher = "checked";
    else userRoleSearchAll = "checked";
        
    User[] users = userDao.getUsers(null, firstNameSearch, lastNameSearch, emailSearch, null, departmentSearch, userRoleSearch);
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
            else if (user.getUserRole() >= 3) {
                response.sendRedirect("index.jsp");
            }
            else {
            
        %>
            <%@ include file="/WEB-INF/jspf/header-loggedin.jspf" %>
        <%
            }
        %>
    </head>
    <input type="hidden" id="modalTrigger" value="<%=message.get(3)%>">
    <body style="padding-bottom: 8rem">
        <div class="main">
            <div class="container">
                <h1>User Management</h1>
                 
                <div class="card" style="margin-top:25px">
                    <div class="card-header">
                        <form action="usermanagement.jsp" method="post">
                            <button type="button" class="btn btn-secondary" data-toggle="collapse" href="#collapseSearch" role="button" aria-expanded="false" aria-controls="collapseExample" data-toggle="button">Filter</button>
                            <input type="hidden" name="firstNameSearch" value="">
                            <input type="hidden" name="lastNameSearch" value="">
                            <input type="hidden" name="departmentSearch" value="">
                            <input type="hidden" name="userRoleSearch" value="">
                            <button type="submit" class="btn btn-outline-secondary">Clear Filter</button>                            
                        </form>
                    </div>
                    <div class="collapse" id="collapseSearch">
                        <div class="card-body">
                            <form action="usermanagement.jsp" method="post">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="firstNameSearch">First Name</label>
                                    <input type="text" class="form-control" name="firstNameSearch" placeholder="First Name" value="<%=firstNameSearch%>">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lastNameSearch">Last Name</label>
                                    <input type="text" class="form-control" name="lastNameSearch" placeholder="Last Name" value="<%=lastNameSearch%>">
                                </div>
                            </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="departmentSearch">Department</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="All" value="All" <%=departmentSearchAll%>>
                                                <label class="form-check-label" for="all">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="English" <%=departmentSearchEnglish%>>
                                                <label class="form-check-label" for="english">English</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Math" <%=departmentSearchMath%>>
                                                <label class="form-check-label" for="math">Math</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Science" <%=departmentSearchScience%>>
                                                <label class="form-check-label" for="science">Science</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Art" <%=departmentSearchArt%>>
                                                <label class="form-check-label" for="art">Art</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Music" <%=departmentSearchMusic%>>
                                                <label class="form-check-label" for="music">Music</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="departmant">Permission Level</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="0" <%=userRoleSearchAll%>>
                                                <label class="form-check-label" for="all">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="1" <%=userRoleSearchAdministrator%>>
                                                <label class="form-check-label" for="administrator">Administrator</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="2" <%=userRoleSearchPrincipal%>>
                                                <label class="form-check-label" for="principal">Principal</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="3" <%=userRoleSearchHeadTeacher%>>
                                                <label class="form-check-label" for="headTeacher">Head Teacher</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="4" <%=userRoleSearchTeacher%>>
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
                            for (int x = 0; x < users.length; x++) {
                                User currentUser = users[x];
                                String userId = currentUser.getUserId().toString();
                                String firstName = currentUser.getFirstName();
                                String lastName = currentUser.getLastName();
                                String email = currentUser.getEmail();
                                String password = currentUser.getPassword();
                                String department = currentUser.getDepartment();
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
                                    
                                <!--EDIT USER MODAL DIALOG-->        
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
                                                <form action="UserServlet" method="post" oninput='passwordConfirmEdit.setCustomValidity(passwordConfirmEdit.value != passwordEdit.value ? "Passwords do not match." : "")'>
                                                    <div class="form-group row">
                                                        <label for="firstName" class="col-sm-4 col-form-label">First Name</label>
                                                        <div class="col-sm-8 firstName">
                                                            <input type="text" class="form-control" name="firstNameEdit" placeholder="First Name">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="lastName" class="col-sm-4 col-form-label">Last Name</label>
                                                        <div class="col-sm-8 lastName">
                                                            <input type="text" class="form-control" name="lastNameEdit" placeholder="Last Name">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="email" class="col-sm-4 col-form-label">Email</label>
                                                        <div class="col-sm-8 email">
                                                            <input type="email" class="form-control" name="emailEdit" placeholder="Email">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="password" class="col-sm-4 col-form-label">Password</label>
                                                        <div class="col-sm-8 password">
                                                            <input type="password" class="form-control" name="passwordEdit" placeholder="Password">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="passwordConfirm" class="col-sm-4 col-form-label">Confirm Password</label>
                                                        <div class="col-sm-8 password">
                                                                <input type="password" class="form-control" name="passwordConfirmEdit" placeholder="Confirm Password">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-4">Department</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="English" value="English">
                                                                <label class="form-check-label" for="english">English</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Math" value="Math" >
                                                                <label class="form-check-label" for="math">Math</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Science" value="Science">
                                                                <label class="form-check-label" for="science">Science</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Art" value="Art">
                                                                <label class="form-check-label" for="art">Art</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Music" value="Music">
                                                                <label class="form-check-label" for="department">Music</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <legend class="col-form-label col-sm-4 pt-0">User Role</legend>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Administrator" value="1">
                                                                <label class="form-check-label" for="administrator">Administrator</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Principal" value="2">
                                                                <label class="form-check-label" for="principal">Principal</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Head Teacher" value="3">
                                                                <label class="form-check-label" for="headTeacher">Head Teacher</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Teacher" value="4">
                                                                <label class="form-check-label" for="teacher">Teacher</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="userId">
                                                        <input type="hidden" name="userIdEdit">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="hidden" name="action" value="edit">
                                                        <input type="hidden" name="redirect" value="usermanagement">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary">Confirm</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>                       
                                <!--MESSAGE MODAL-->
                                <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="messageModalLabel"><%=message.get(0)%></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>    
                                            </div>                            
                                            <div class="modal-body">
                                                    <div class="alert alert-<%=message.get(2)%> mr-auto" role="alert" style="text-align: center"><%=message.get(1)%></div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            </div>
                                        </div> 
                                    </div>   
                                </div>                          
                                <!--DELETE MESSAGE MODAL AFTER DELETE-->                                
                                <button type=button" class="btn btn-danger"  data-toggle="modal" data-target="#userDeleteModal"
                                        data-toggle="modal"role="button" data-userid="<%=userId%>" data-firstname="<%=firstName%>" 
                                        data-lastname="<%=lastName%>">Delete</button>
                                    
                                        <div class="modal fade" id="userDeleteModal" tabindex="-1" role="dialog" aria-labelledby="userDeleteModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="userDeleteModalLabel"></h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>                                            
                                                    <form action="UserServlet" method="post">
                                                        <div class="modal-body">
                                                            <p>Are you sure you want to delete this user?</p>
                                                            <p>This action cannot be undone.</p>
                                                        </div>
                                                        <div class="userId">
                                                            <input type="hidden" name="userIdDelete">        
                                                        </div>
                                                        <div class="modal-footer">
                                                            <input type="hidden" name="action" value="delete">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                            <button type="submit" class="btn btn-primary btn-danger">Confirm</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
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
                <!--ADD USER MODAL DIALOG-->         
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
                                <form oninput='passwordConfirmAdd.setCustomValidity(passwordConfirmAdd.value != passwordAdd.value ? "Passwords do not match." : "")' method="post" action="UserServlet"> 
                                    <div class="form-group row">
                                        <label for="firstName" class="col-sm-4 col-form-label">First Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="firstNameAdd" placeholder="First Name" required="true" minlength="1" maxlength="32" value="<%=firstNameAdd%>">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="lastName" class="col-sm-4 col-form-label">Last Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="lastNameAdd" placeholder="Last Name" required="true" minlength="1" maxlength="32" value="<%=lastNameAdd%>">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="email" class="col-sm-4 col-form-label">Email</label>
                                        <div class="col-sm-8 email">
                                            <input type="email" class="form-control" name="emailAdd" placeholder="Email" required="true" minlength="1" maxlength="64" value="<%=emailAdd%>">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="password" class="col-sm-4 col-form-label">Password</label>
                                        <div class="col-sm-8">
                                            <div class="input-group" id="show_hide_password">
                                                <input type="password" class="form-control pwdadd1" name="passwordAdd" placeholder="Password" required="true" minlength="6" maxlength="16" value="<%=passwordAdd%>">
                                                <button class="btn btn-outline-dark revealdelete1" type="button" data-toggle="button">show</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="passwordConfirm" class="col-sm-4 col-form-label">Confirm Password</label>
                                        <div class="col-sm-8">
                                            <div class="input-group" id="show_hide_password">
                                                <input type="password" class="form-control pwdadd2" name="passwordConfirmAdd" name="passwordConfirm" placeholder="Confirm Password" required="true" minlength="6" maxlength="16" value="<%=passwordAdd%>">
                                                <button class="btn btn-outline-dark revealdelete2" type="button" data-toggle="button">show</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-4">Department</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="English" <%=depratmentAddEnglish%>>
                                                <label class="form-check-label" for="english">English</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Math" <%=depratmentAddMath%>>
                                                <label class="form-check-label" for="math">Math</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Science" <%=depratmentAddScience%>>
                                                <label class="form-check-label" for="science">Science</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Art" <%=depratmentAddArt%>>
                                                <label class="form-check-label" for="art">Art</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Music" <%=depratmentAddMusic%>>
                                                <label class="form-check-label" for="department">Music</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <legend class="col-form-label col-sm-4 pt-0">User Role</legend>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Administrator" value="1" <%=userRoleAddAdministrator%>>
                                                <label class="form-check-label" for="administrator">Administrator</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Principal" value="2" <%=userRoleAddPrincipal%>>
                                                <label class="form-check-label" for="principal">Principal</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Head Teacher" value="3" <%=userRoleAddHeadTeacher%>>
                                                <label class="form-check-label" for="headTeacher">Head Teacher</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" id="Teacher" value="4" <%=userRoleAddTeacher%>>
                                                <label class="form-check-label" for="teacher">Teacher</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                    <%
                                        if (message.get(1) != "") {
                                    %>      
                                    <div class="alert alert-<%=message.get(2)%> mr-auto" role="alert" style="text-align: center"><%=message.get(1)%></div>
                                    <%
                                        }
                                    %>   
                                        <input type="hidden" name="action" value="add">                                 
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary submit">Confirm</button>                                        
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <%
        session.removeAttribute("firstNameAdd");
        session.removeAttribute("lastNameAdd");
        session.removeAttribute("emailAdd");
        session.removeAttribute("passwordAdd");
        session.removeAttribute("departmentAdd");
        session.removeAttribute("userRoleAdd");
        session.removeAttribute("message");
    %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/usermanagement.js"></script>
    </body>
        <%@ include file="/WEB-INF/jspf/footer-static.jspf"%> 
</html>
