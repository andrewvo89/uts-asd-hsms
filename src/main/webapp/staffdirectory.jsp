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
    </head>
    <%
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
        String depratmentAddAdministration = "", depratmentAddEnglish = "", depratmentAddMath = "", depratmentAddScience = "", depratmentAddArt = "";
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
        if (departmentAdd.equals("English")) depratmentAddEnglish = "checked";
        else if(departmentAdd.equals("Math")) depratmentAddMath = "checked";
        else if(departmentAdd.equals("Science")) depratmentAddScience = "checked";
        else if(departmentAdd.equals("Art")) depratmentAddArt = "checked";
        else depratmentAddAdministration = "checked";
        if(userRoleAdd == 2) userRoleAddPrincipal = "checked";
        else if(userRoleAdd == 3) userRoleAddHeadTeacher = "checked";
        else if(userRoleAdd == 4) userRoleAddTeacher = "checked";
        else userRoleAddAdministrator = "checked";

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

         User[] users = userDao.getUsers(null, firstNameSearch, lastNameSearch, null, null, emailSearch, null, departmentSearch, userRoleSearch);
    %>
    <body>
        <div class="main">
            <div class="container"><br>
                <h1>Staff Directory</h1>
                 <!--Filter--> 
                  <div class="card" style="margin-top:25px">
                    <div class="card-header">
                        <form action="staffdirectory.jsp" method="post">
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
                            <form action="staffdirectory.jsp" method="post">
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
                                        <label for="departmant">Staff Role</label>
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
    </body>
            <%@ include file="/WEB-INF/jspf/footer.jspf" %>     
</html>
