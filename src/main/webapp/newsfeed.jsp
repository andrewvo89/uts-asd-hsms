<%-- 
    Document   : Newsfeed
    Created on : 2019-8-17, 17:22:24
    Author     : ALVIN
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="uts.asd.hsms.controller.JobBoardController"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="ConnServlet" flush="true" />
<%@page import="uts.asd.hsms.model.*"%>

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
        <title>News Feed</title>
    </head>
    <body>
                <%//Check if there is a valid user in the session
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "jobboard");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
        JobBoardController controller = new JobBoardController(session);
        ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        //Initialize notification messages for pop up Modals 1.message header 2.message body 3.message type
        if (message == null) { message = new ArrayList<String>();  message.add(""); message.add(""); message.add(""); }     
        String titleSearch = request.getParameter("titleSearch"); if (titleSearch == null) titleSearch = ""; 
        String workTypeSelection = request.getParameter("workTypeSearch");
        String[] workTypeSearch = controller.getWorkTypeSearch(workTypeSelection);
        String departmentSelection = request.getParameter("departmentSearch");
        String[] departmentSearch = controller.getDepartmentSearch(departmentSelection);     
        //Return search results in the form of Jobs for populating the table
        Job[] jobs = controller.getJobs(null, titleSearch, null, workTypeSelection, departmentSelection, "Open", null, null, true, "postdate", -1);
        %>
        <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
        <div class="main">
            <div class="container">
                <h1>News Feed</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">News Feed</li>
                    </ol>
                </nav>
                <div class="card">
                    <div class="card-header">
                        <form action="newsfeed.jsp" method="post">
                            <div class="float-left">
                                <a class="btn btn-secondary" data-toggle="collapse" href="#collapseSearch" aria-expanded="false" aria-controls="collapseSearch">Filter (<%=jobs.length%>)</a>
                                <input type="hidden" name="titleSearch" value="">
                                <input type="hidden" name="workTypeSearch" value="">
                                <input type="hidden" name="departmentSearch" value="">
                                <input type="hidden" name="statusSearch" value="">
                                <button type="submit" class="btn btn-outline-secondary">Clear Filter</button>
                            </div>
                            <div class="float-right align-items-center py-2">
                                <span>Quick Filters:</span>
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
                            <form action="newsfeed.jsp" method="post">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>Title</label>
                                        <input type="text" class="form-control" name="titleSearch" placeholder="Title" value="<%=titleSearch%>">
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
                                                <input class="form-check-input" type="radio" name="departmentSearch"  id="departmentSearchMath" value="Math" <%=departmentSearch[3]%>>
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
                                </div> 
                                <button id="searchButton" type="submit" class="btn btn-primary mb-2">Search</button>
                            </form> 
                        </div>
                    </div>
                </div> 
                <%
                    //Loop through results of MongoDB search result and place them in a table
                    for (int x = 0; x < jobs.length; x++) {
                        Job currentJob = jobs[x];
                        ObjectId jobId = currentJob.getJobId();
                        String title = currentJob.getTitle();
                        String description = currentJob.getDescription();
                        String workType = currentJob.getWorkType();
                        String department = currentJob.getDepartment();
                        ObjectId userId = user.getUserId();
                        String firstName = user.getFirstName();
                        String lastName = user.getLastName();
                        String email = user.getEmail();
                        String phone = user.getPhone();
                        String footerLabel = controller.getFooterLabel(currentJob.getPostDate());                        
                %>
                <br>
                <div class="card">                        
                    <div class="card-header float-right align-items-center py-2">
                       <div style="float: left"> 
                        <span class="btn-warning badge badge-pill">Art</span>
                        
                        </div>
                        <p style="float:center">Post date:20-09-2019 Author:Alvin</p>

                    </div>
                    <div class="card-body">
                        <h4 class="card-title">Eearly Student Feedback Survey - Feeback Loop</h4>
                        <p class="card-text">Dear Students,

Thanks for completing the early SFS survey and feedback. I take feedback seriously and always strive to continuously improve the teaching and learning.</p>
                    </div>
                    <div class="card-footer text-muted">10 days ago</div>
                </div>                
    

                <%
                    }
                %>        
            </div>
        </div>
        <%
            //Clear error message from Session
            session.removeAttribute("message");
        %>
        <div class="main">
            <div class="container">
                <h1>News Feed</h1>
                             
                
                <h1>Holiday Notification</h1>
                <p>Posted on: 18 08 2019</p>
                <p>Department: All</p>
                <p>Author:Principal</p>
                <h8>Next week is Holiday!!</h8>
            </div>



                
        </div>

        
        
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
