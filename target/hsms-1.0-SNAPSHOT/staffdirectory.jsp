<%-- 
    Document   : staffdirectory
    Created on : 2019-8-17, 17:22:24
    Author     : ALVIN
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


<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>Staff Contact</title>
            </head>
            <body>
        <%
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "staffdirectory");
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

    <%
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
        User[] users = controller.getUsers(null, firstNameSearch, lastNameSearch, null, null, emailSearch, null, departmentSelection, userRoleSelection, "firstname", 1);
    %>

        <div class="main">
            <div class="container"><br>
                <h1>Staff Directory</h1>
                
                              <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">User Management</li>
                    </ol>
                </nav>              
                <div class="card">
                    <div class="card-header">
                        <form action="staffdirectory.jsp" method="post">
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

                
                
                

                                                
                <table class="table">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">First Name</th>
                            <th scope="col">Last Name</th>
                            <th scope="col">Department</th>
                            <th scope="col">Role</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone number</th>                       
                            <th scope="col">Office location</th>
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
                            <td><%=userRoleString%></td>
                            <td><%=email%></td>
                            <td><%=phone%></td>
                            <td><%=location%></td>
                            
                            
                            
                            
                            
                                                    <%
                            }
                        %>

                            </tr>
                    

                        
                                   <tr>
                            <td>Alice</td>
                            <td>Lo</td>
                            <td>English</td>
                            <td>Principal</td>
                            <td>principal@hsms.edu.au</td>
                            <td>0400000000</td>
                            <td>CB11.02.011</td>
                                   </tr>


                        </tbody>
                    </table>
       
            </div>
        </div>
     

        <%@ include file="/WEB-INF/jspf/footer.jspf" %> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
                <script src="js/usermanagement.js"></script>
    </body>
 
</html>
