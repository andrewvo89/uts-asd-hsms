<%-- 
    Document   : usermanagement
    Created on : 14 Aug. 2019, 10:58:09 pm
    Author     : Andrew
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.controller.*"%>
<%@page import="java.io.*,java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="ConnServlet" flush="true" />
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
        <title>User Management</title>
    </head>
    <body>
    <%//Check if there is a valid user in the session
        User user = (User)session.getAttribute("user");
        if (user == null) {
            session.setAttribute("redirect", "usermanagement");
    %>   
            <jsp:include page="LoginServlet" flush="true" />
    <%
        }
        else {//If user is not Principal or Adminstrator role
            if (user.getUserRole() > 2) %><jsp:include page="LoginDeniedServlet" flush="true" />
            <%@ include file="/WEB-INF/jspf/header.jspf"%>
    <%
        }
        UserController controller = new UserController(session);
        ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        //Initialize notification messages for pop up Modals 1.message header 2.message body 3.message type
        if (message == null) { message = new ArrayList<String>();  message.add(""); message.add(""); message.add(""); }
        //Prefill Search Data variables
        String firstNameSearch = request.getParameter("firstNameSearch"); if (firstNameSearch == null) firstNameSearch = "";
        String lastNameSearch = request.getParameter("lastNameSearch"); if (lastNameSearch == null) lastNameSearch = "";
        String emailSearch = request.getParameter("emailSearch"); if (emailSearch == null) emailSearch = "";    
        String departmentSelection = request.getParameter("departmentSearch"); 
        String[] departmentSearch = controller.getDepartmentSearch(departmentSelection);  
        int userRoleSelection = 0;    
        if (request.getParameter("userRoleSearch") != null) {
            try { userRoleSelection = Integer.parseInt(request.getParameter("userRoleSearch")); }
            catch (NumberFormatException ex) { userRoleSelection = 0; }
        }
        String[] userRoleSearch = controller.getUserRoleSearch(userRoleSelection);  
        //Return search results in the form of Users for populating the table
        User[] users = controller.getUsers(null, firstNameSearch, lastNameSearch, null, null, emailSearch, null, departmentSelection, userRoleSelection, true, "firstname", 1);
    %>
        <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
        <div class="main">
            <div class="container">
                <h2>User Management</h2>   
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">User Management</li>
                    </ol>
                </nav>              
                <div class="card">
                    <div class="card-header">
                        <form action="usermanagement.jsp" method="post">
                            <div class="float-left">
                                <a class="btn btn-secondary" data-toggle="collapse" href="#collapseSearch" aria-expanded="false" aria-controls="collapseSearch">Filter (<%=users.length%>)</a>
                                <input type="hidden" name="firstNameSearch" value="">
                                <input type="hidden" name="lastNameSearch" value="">
                                <input type="hidden" name="departmentSearch" value="">
                                <input type="hidden" name="userRoleSearch" value="">
                                <button type="submit" class="btn btn-outline-secondary">Clear Filter</button>
                            </div>
                            <div class="float-right align-items-center py-2">
                                <span>Quick Filters:</span>
                                <button id="userRoleButtonAdministrator" class="btn btn-outline-info badge badge-pill" type="button">Administrator</button>
                                <button id="userRoleButtonPrincipal" class="btn btn-outline-info badge badge-pill" type="button">Principal</button>
                                <button id="userRoleButtonHeadTeacher" class="btn btn-outline-info badge badge-pill" type="button">Head Teacher</button>
                                <button id="userRoleButtonTeacher" class="btn btn-outline-info badge badge-pill" type="button">Teacher</button>
                                <button id="departmentButtonAdministration" class="btn btn-outline-warning badge badge-pill" type="button">Administration</button>
                                <button id="departmentButtonEnglish" class="btn btn-outline-warning badge badge-pill" type="button">English</button>
                                <button id="departmentButtonMath" class="btn btn-outline-warning badge badge-pill" type="button">Math</button>
                                <button id="departmentButtonScience" class="btn btn-outline-warning badge badge-pill" type="button">Science</button>
                                <button id="departmentButtonArt" class="btn btn-outline-warning badge badge-pill" type="button">Art</button>
                            </div>                            
                        </form>
                    </div>
                    <!--SEARCH COLLAPSIBLE CARD-->
                    <div class="collapse" id="collapseSearch">
                        <div class="card-body">
                            <form action="usermanagement.jsp" method="post">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>First Name</label>
                                        <input type="text" class="form-control" name="firstNameSearch" placeholder="First Name" value="<%=firstNameSearch%>">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Last Name</label>
                                        <input type="text" class="form-control" name="lastNameSearch" placeholder="Last Name" value="<%=lastNameSearch%>">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>Department</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="All" <%=departmentSearch[0]%>>
                                                <label class="form-check-label">All</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchAdministration" value="Administration" <%=departmentSearch[1]%>>
                                                <label class="form-check-label">Administration</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchEnglish" value="English" <%=departmentSearch[2]%>>
                                                <label class="form-check-label">English</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchMath" value="Math" <%=departmentSearch[3]%>>
                                                <label class="form-check-label">Math</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchScience" value="Science" <%=departmentSearch[4]%>>
                                                <label class="form-check-label">Science</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchArt" value="Art" <%=departmentSearch[5]%>>
                                                <label class="form-check-label">Art</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Permission Level</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" value="0" <%=userRoleSearch[0]%>>
                                                <label class="form-check-label">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" id="userRoleSearchAdministrator" value="1" <%=userRoleSearch[1]%>>
                                                <label class="form-check-label">Administrator</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" id="userRoleSearchPrincipal" value="2" <%=userRoleSearch[2]%>>
                                                <label class="form-check-label">Principal</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" id="userRoleSearchHeadTeacher" value="3" <%=userRoleSearch[3]%>>
                                                <label class="form-check-label">Head Teacher</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="userRoleSearch" id="userRoleSearchTeacher" value="4" <%=userRoleSearch[4]%>>
                                                <label class="form-check-label">Teacher</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                </div> 
                                <button id="searchButton" type="submit" class="btn btn-primary mb-2">Search</button>
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
                                ObjectId userId = currentUser.getUserId();
                                String firstName = currentUser.getFirstName();
                                String lastName = currentUser.getLastName();
                                String phone = currentUser.getPhone();
                                String location = currentUser.getLocation();
                                String email = currentUser.getEmail();
                                String department = currentUser.getDepartment();
                                String[] departmentEdit = controller.getDepartmentEdit(department);
                                int userRole = currentUser.getUserRole();
                                String userRoleString = controller.getUserRoleString(userRole);
                                String[] userRoleEdit = controller.getUserRoleEdit(userRole);
                        %>
                        <tr>
                            <td><%=firstName%></td>
                            <td><%=lastName%></td>
                            <td><%=department%></td>
                            <td><%=email%></td>
                            <td><%=userRoleString%></td>
                            <td>
                                <button type="button" class="btn btn-primary" id="userEditButton<%=x%>" data-toggle="modal" data-target="#userEditModal<%=x%>">Edit</button>
                                <button type="button" class="btn btn-danger"  data-toggle="modal" data-target="#userDeleteModal<%=x%>">Delete</button>
                                
                                <!--EDIT USER MODAL DIALOG-->        
                                <div class="modal fade" id="userEditModal<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit <%=firstName%> <%=lastName%></h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="UserServlet" method="post">
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">First Name</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="firstNameEdit" placeholder="First Name" value="<%=firstName%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Last Name</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="lastNameEdit" placeholder="Last Name" value="<%=lastName%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Phone</label>
                                                        <div class="col-sm-8">
                                                            <input type="tel" class="form-control" name="phoneEdit" id="phoneEdit<%=x%>" placeholder="Phone" value="<%=phone%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Location</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="locationEdit" placeholder="Location" value="<%=location%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Email</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="emailEdit" id="emailEdit<%=x%>" placeholder="Email" value="<%=email%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Password</label>
                                                        <div class="col-sm-8">
                                                            <div class="input-group">
                                                                <input type="password" class="form-control" id="passwordEdit<%=x%>" data-index="<%=x%>" name="passwordEdit" placeholder="New Password">
                                                                <button class="btn btn-outline-dark" id="revealEdit<%=x%>" data-index="<%=x%>" type="button" data-toggle="button">show</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Confirm Password</label>
                                                        <div class="col-sm-8">
                                                            <div class="input-group">
                                                                <input type="password" class="form-control" id="passwordConfirmEdit<%=x%>" data-index="<%=x%>" name="passwordConfirmEdit" placeholder="Confirm Password">    
                                                                <button class="btn btn-outline-dark" id="revealConfirmEdit<%=x%>" data-index="<%=x%>" type="button" data-toggle="button">show</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-4">Department</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" value="Administration" <%=departmentEdit[0]%>>
                                                                <label class="form-check-label">Administration</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" value="English" <%=departmentEdit[1]%>>
                                                                <label class="form-check-label">English</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" value="Math" <%=departmentEdit[2]%>>
                                                                <label class="form-check-label">Math</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" value="Science" <%=departmentEdit[3]%>>
                                                                <label class="form-check-label">Science</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="departmentEdit" value="Art" <%=departmentEdit[4]%>>
                                                                <label class="form-check-labe">Art</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-form-label col-sm-4 pt-0">User Role</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" value="1" <%=userRoleEdit[0]%>>
                                                                <label class="form-check-label">Administrator</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" value="2" <%=userRoleEdit[1]%>>
                                                                <label class="form-check-label">Principal</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" value="3" <%=userRoleEdit[2]%>>
                                                                <label class="form-check-label">Head Teacher</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="userRoleEdit" value="4" <%=userRoleEdit[3]%>>
                                                                <label class="form-check-label">Teacher</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="hidden" name="userIdEdit" value="<%=userId.toString()%>">
                                                        <input type="hidden" name="action" value="edit">
                                                        <input type="hidden" name="redirect" value="usermanagement">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary" id="userEditConfirmButton<%=x%>">Confirm</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>                                  
                                <!--DELETE CONFIRMATION MODAL-->
                                <div class="modal fade" id="userDeleteModal<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Delete <%=firstName%> <%=lastName%></h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>                                            
                                            <form action="UserServlet" method="post">
                                                <div class="modal-body">
                                                    <p>Are you sure you want to delete this user?</p>
                                                    <p>This action cannot be undone.</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="hidden" name="userIdDelete" value="<%=userId.toString()%>">        
                                                    <input type="hidden" name="action" value="delete">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary btn-danger">Confirm</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <div class="float-right">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#userAddModal">Add User</button>
                </div>                
                <!--ADD USER MODAL DIALOG-->         
                <div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add User</h5>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="UserServlet"> 
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">First Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="firstNameAdd" placeholder="First Name">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Last Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="lastNameAdd" placeholder="Last Name">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Phone</label>
                                        <div class="col-sm-8">
                                            <input type="tel" class="form-control" name="phoneAdd" placeholder="Phone">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Location</label>
                                        <div class="col-sm-8 location">
                                            <input type="text" class="form-control" name="locationAdd" placeholder="Location">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Email</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="emailAdd" placeholder="Email">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Password</label>
                                        <div class="col-sm-8">
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="passwordAdd" name="passwordAdd" placeholder="Password">
                                                <button class="btn btn-outline-dark" id="revealAdd" type="button" data-toggle="button">show</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Confirm Password</label>
                                        <div class="col-sm-8">
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="passwordConfirmAdd" name="passwordConfirmAdd" placeholder="Confirm Password">
                                                <button class="btn btn-outline-dark" id="revealConfirmAdd" type="button" data-toggle="button">show</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-4">Department</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Administration" checked>
                                                <label class="form-check-label">Administration</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="English">
                                                <label class="form-check-label">English</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Math">
                                                <label class="form-check-label">Math</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Science">
                                                <label class="form-check-label">Science</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Art">
                                                <label class="form-check-label">Art</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-form-label col-sm-4 pt-0">User Role</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="1" checked>
                                                <label class="form-check-label">Administrator</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="2">
                                                <label class="form-check-label">Principal</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="3">
                                                <label class="form-check-label">Head Teacher</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="userRoleAdd" value="4">
                                                <label class="form-check-label">Teacher</label>
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
                <!--MESSAGE MODAL AFTER ADD, EDIT OR DELETE ACTION-->
                <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><%=message.get(0)%></h5>
                                <button type="button" class="close" data-dismiss="modal">
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