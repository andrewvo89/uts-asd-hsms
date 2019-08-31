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
        <%//Check if there is a valid user in the session
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "usermanagement");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
                if (user.getUserRole() > 2) response.sendRedirect("index.jsp");
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
        %> 
    </head>
    <%
        UserDao userDao = (UserDao)session.getAttribute("userDao");
        ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        if (message == null) {//Initialize notification messages for pop up Modals
            message = new ArrayList<String>();//1.message header 2.message body 3.message type
            message.add(""); message.add(""); message.add("");
        }

        //Prefill Search Data variables
        String firstNameSearch = request.getParameter("firstNameSearch");
        String lastNameSearch = request.getParameter("lastNameSearch");
        String departmentSearch = request.getParameter("departmentSearch");
        String emailSearch = request.getParameter("emailSearch");
        String departmentSearchAdministration="", departmentSearchAll="", departmentSearchEnglish="", departmentSearchMath="", departmentSearchScience="", departmentSearchArt="";
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
        else if(departmentSearch.equals("Administration")) departmentSearchAdministration = "checked";
        else departmentSearchAll = "checked";    
        if (userRoleSearch == 1) userRoleSearchAdministrator = "checked";
        else if(userRoleSearch == 2) userRoleSearchPrincipal = "checked";
        else if(userRoleSearch == 3) userRoleSearchHeadTeacher = "checked";
        else if(userRoleSearch == 4) userRoleSearchTeacher = "checked";
        else userRoleSearchAll = "checked";
        //Return search results in the form of Users for populating the table
        User[] users = userDao.getUsers(null, firstNameSearch, lastNameSearch, null, null, emailSearch, null, departmentSearch, userRoleSearch);
    %>
    <body style="padding-bottom: 8rem">
    <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
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
                    <!--SEARCH MODULE-->
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
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="All" <%=departmentSearchAll%>>
                                                <label class="form-check-label">All</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Administration" <%=departmentSearchAdministration%>>
                                                <label class="form-check-label">Administration</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="English" <%=departmentSearchEnglish%>>
                                                <label class="form-check-label">English</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Math" <%=departmentSearchMath%>>
                                                <label class="form-check-label">Math</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Science" <%=departmentSearchScience%>>
                                                <label class="form-check-label">Science</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="Art" <%=departmentSearchArt%>>
                                                <label class="form-check-label">Art</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="departmant">Permission Level</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="0" <%=userRoleSearchAll%>>
                                                <label class="form-check-label">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="1" <%=userRoleSearchAdministrator%>>
                                                <label class="form-check-label">Administrator</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="2" <%=userRoleSearchPrincipal%>>
                                                <label class="form-check-label">Principal</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="3" <%=userRoleSearchHeadTeacher%>>
                                                <label class="form-check-label">Head Teacher</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="4" <%=userRoleSearchTeacher%>>
                                                <label class="form-check-label">Teacher</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                </div> 
                                <button type="submit" class="btn btn-primary mb-2">Search</button>
                            </form> 
                        </div>
                    </div>
                </div>
                <!--POPULATE TABLE WITH SEARCH RESULTS-->
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
                            //Loop through results of MongoDB search result and place them in a table
                            for (int x = 0; x < users.length; x++) {
                                User currentUser = users[x];
                                String userId = currentUser.getUserId().toString();
                                String firstName = currentUser.getFirstName();
                                String lastName = currentUser.getLastName();
                                String phone = currentUser.getPhone();
                                String location = currentUser.getLocation();
                                String email = currentUser.getEmail();
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
                                data-userid="<%=userId%>" data-firstname="<%=firstName%>" data-lastname="<%=lastName%>" data-phone="<%=phone%>" 
                                data-location="<%=location%>" data-department="<%=department%>" data-email="<%=email%>" 
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
                                                <form action="UserServlet" method="post">
                                                    <div class="form-group row">
                                                        <label for="firstNameEdit" class="col-sm-4 col-form-label">First Name</label>
                                                        <div class="col-sm-8 firstName">
                                                            <input type="text" class="form-control" name="firstNameEdit" placeholder="First Name" required="true" minlength="1" maxlength="32">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="lastNameEdit" class="col-sm-4 col-form-label">Last Name</label>
                                                        <div class="col-sm-8 lastName">
                                                            <input type="text" class="form-control" name="lastNameEdit" placeholder="Last Name" required="true" minlength="1" maxlength="32">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="phoneEdit" class="col-sm-4 col-form-label">Phone</label>
                                                        <div class="col-sm-8 phone">
                                                            <input type="tel" class="form-control" name="phoneEdit" placeholder="Phone" required="true" minlength="1" maxlength="10" pattern="^[0-9]*$" title="Phone must include numbers only">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="locationEdit" class="col-sm-4 col-form-label">Location</label>
                                                        <div class="col-sm-8 location">
                                                            <input type="text" class="form-control" name="locationEdit" placeholder="Location" required="true" minlength="1" maxlength="16">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="emailEdit" class="col-sm-4 col-form-label">Email</label>
                                                        <div class="col-sm-8 email">
                                                            <input type="email" class="form-control" name="emailEdit" placeholder="Email" required="true" minlength="1" maxlength="64" pattern="^[A-Za-z0-9._-]+@hsms.edu.au$" title="Email Address must end in @hsms.edu.au">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="passwordEdit" class="col-sm-4 col-form-label">Password</label>
                                                        <div class="col-sm-8">
                                                            <div class="input-group" id="show_hide_password">
                                                                <input type="password" class="form-control pwdedit1" id="passwordedit" name="passwordEdit" placeholder="New Password" maxlength="16" pattern="^.*(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=\S+$).*$" title="Password must contain at least 1 Lower Case, 1 Upper Case and 1 Special Character">
                                                                <button class="btn btn-outline-dark revealedit1" type="button" data-toggle="button">show</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="passwordConfirmEdit" class="col-sm-4 col-form-label">Confirm Password</label>
                                                        <div class="col-sm-8">
                                                            <div class="input-group" id="show_hide_password">
                                                                <input type="password" class="form-control pwdedit2" id="passwordconfirmedit" name="passwordConfirmEdit" placeholder="Confirm Password" maxlength="16">
                                                                <button class="btn btn-outline-dark revealedit2" type="button" data-toggle="button">show</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-4">Department</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Administration" value="Administration">
                                                                <label class="form-check-label">Administration</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="English" value="English">
                                                                <label class="form-check-label">English</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Math" value="Math" >
                                                                <label class="form-check-label">Math</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Science" value="Science">
                                                                <label class="form-check-label">Science</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" id="Art" value="Art">
                                                                <label class="form-check-labe">Art</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <legend class="col-form-label col-sm-4 pt-0">User Role</legend>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Administrator" value="1">
                                                                <label class="form-check-label">Administrator</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Principal" value="2">
                                                                <label class="form-check-label">Principal</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Head Teacher" value="3">
                                                                <label class="form-check-label">Head Teacher</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" id="Teacher" value="4">
                                                                <label class="form-check-label">Teacher</label>
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
                                <!--MESSAGE MODAL AFTER ADD, EDIT OR DELETE ACTION-->
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
                                <!--DELETE CONFIRMATION MODAL-->                                
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
                                <form method="post" action="UserServlet"> 
                                    <div class="form-group row">
                                        <label for="firstNameAdd" class="col-sm-4 col-form-label">First Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="firstNameAdd" placeholder="First Name" required="true" minlength="1" maxlength="32">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="lastNameAdd" class="col-sm-4 col-form-label">Last Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="lastNameAdd" placeholder="Last Name" required="true" minlength="1" maxlength="32">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="phoneAdd" class="col-sm-4 col-form-label">Phone</label>
                                        <div class="col-sm-8">
                                            <input type="tel" class="form-control" name="phoneAdd" placeholder="Phone" required="true" minlength="1" maxlength="10" pattern="^[0-9]*$" title="Phone must include numbers only">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="locationAdd" class="col-sm-4 col-form-label">Location</label>
                                        <div class="col-sm-8 location">
                                            <input type="text" class="form-control" name="locationAdd" placeholder="Location" required="true" minlength="1" maxlength="16">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="emailAdd" class="col-sm-4 col-form-label">Email</label>
                                        <div class="col-sm-8">
                                            <input type="email" class="form-control" name="emailAdd" placeholder="Email" required="true" minlength="1" maxlength="64" pattern="^[A-Za-z0-9._-]+@hsms.edu.au$" title="Email Address must end in @hsms.edu.au">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="passwordAdd" class="col-sm-4 col-form-label">Password</label>
                                        <div class="col-sm-8">
                                            <div class="input-group" id="show_hide_password">
                                                <input type="password" class="form-control pwdadd1" id="passwordadd" name="passwordAdd" placeholder="Password" minlength="6" maxlength="16" pattern="^.*(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=\S+$).*$" title="Password must contain at least 1 Lower Case, 1 Upper Case and 1 Special Character">
                                                <button class="btn btn-outline-dark revealadd1" type="button" data-toggle="button">show</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="passwordConfirmAdd" class="col-sm-4 col-form-label">Confirm Password</label>
                                        <div class="col-sm-8">
                                            <div class="input-group" id="show_hide_password">
                                                <input type="password" class="form-control pwdadd2" id="passwordconfirmadd" name="passwordConfirmAdd" name="passwordConfirm" placeholder="Confirm Password">
                                                <button class="btn btn-outline-dark revealadd2" type="button" data-toggle="button">show</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-4">Department</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Administration" checked>
                                                <label class="form-check-label" for="department">Administration</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="English">
                                                <label class="form-check-label" for="english">English</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Math">
                                                <label class="form-check-label" for="math">Math</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Science">
                                                <label class="form-check-label" for="science">Science</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Art">
                                                <label class="form-check-label" for="art">Art</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <legend class="col-form-label col-sm-4 pt-0">User Role</legend>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="1" checked>
                                                <label class="form-check-label" for="administrator">Administrator</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="2">
                                                <label class="form-check-label" for="principal">Principal</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="3">
                                                <label class="form-check-label" for="headTeacher">Head Teacher</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="4">
                                                <label class="form-check-label" for="teacher">Teacher</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
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
        //Clear error message from Session
        session.removeAttribute("message");
    %>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/usermanagement.js"></script>
    </body>
</html>
