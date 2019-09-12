<%-- 
    Document   : userprofile
    Created on : 17 Aug. 2019, 7:38:38 am
    Author     : Andrew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.asd.hsms.model.*"%>
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
        <title>User Profile</title>

    </head>

    <body>
        <%//Check if there is a valid user in the session
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
            }//Initialize any error messages from UserServlet      
        ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        if (message == null) {
            message = new ArrayList<String>();//1.message header 2.message body 3.message type
            message.add(""); message.add(""); message.add("");
        }//Get properties from Session User
        String userId = user.getUserIdString();
        String firstName = user.getFirstName();
        String lastName = user.getLastName();
        String phone = user.getPhone();
        String location = user.getLocation();
        String email = user.getEmail();
        String department = user.getDepartment();
        int userRole = user.getUserRole();
    %>
    <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
        <div class="main">
            <div class="container userprofile">
                <h2>Edit Profile</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">User Profile</li>
                    </ol>
                </nav>
                <!--PRE-FILL FIELD DATA FROM SESSION USER PROPERTIES-->
                <div class="card">
                    <div class="card-body">
                        <form action="UserServlet" method="post">
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">First Name</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="firstNameEdit" placeholder="First Name" value="<%=firstName%>" readonly>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Last Name</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="lastNameEdit" placeholder="Last Name" value="<%=lastName%>" readonly>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Email</label>
                                <div class="col-sm-8">
                                    <input type="email" class="form-control" name="emailEdit" placeholder="Email" value="<%=email%>" readonly>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Department</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="departmentEdit" placeholder="Department" value="<%=department%>" readonly>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Phone</label>
                                <div class="col-sm-8">
                                    <input type="tel" class="form-control" name="phoneEdit" placeholder="Phone" value="<%=phone%>">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Location</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="locationEdit" placeholder="Location" value="<%=location%>">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Password</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="passwordEdit" name="passwordEdit" placeholder="New Password">
                                        <button class="btn btn-outline-dark" id="revealEdit" type="button" data-toggle="button">show</button> 
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-4 col-form-label">Confirm Password</label>
                                <div class="col-sm-8">
                                     <div class="input-group">
                                        <input type="password" class="form-control" id="passwordConfirmEdit" name="passwordConfirmEdit" placeholder="Confirm Password">
                                        <button class="btn btn-outline-dark" id="revealConfirmEdit" type="button" data-toggle="button">show</button> 
                                    </div>
                                </div>
                            </div>
                            <!--HIDDEN FIELDS TO HOLD DATA FROM SESSION USER TO BE PUSHED THROUGH TO SERVLET FOR PROCESSING-->
                            <div class="float-right">   
                                <input type="hidden" name="userIdEdit" value="<%=userId%>">
                                <input type="hidden" name="userRoleEdit" value="<%=userRole%>">
                                <input type="hidden" name="redirect" value="userprofile">
                                <input type="hidden" name="action" value="edit">                             
                                <a class="btn btn-secondary" href="index.jsp">Close</a>
                                <button type="submit" class="btn btn-primary">Confirm</button>
                            </div>
                        </form>
                        <!--MESSAGE MODAL EDIT ACTION-->
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
            </div>
        </div>
        <%  //Clear error message from Sessions                          
            session.removeAttribute("message");
        %>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/userprofile.js"></script>
    </body>
</html>
