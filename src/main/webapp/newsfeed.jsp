<%-- 
    Document   : Newsfeed
    Created on : 2019-8-17, 17:22:24
    Author     : ALVIN
--%>


<%@page import="java.util.LinkedList"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="uts.asd.hsms.controller.FeedController"%>
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
                session.setAttribute("redirect", "newsfeed");
        %>
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {

System.out.print("Alvin Test: this is a test"+user.toString());
System.out.print("first name:"+user.getFirstName());
System.out.print("last name:"+user.getLastName());
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }

//*
        FeedController controller = new FeedController(session);
 LinkedList<DBObject> feeds = controller.getFeeds();
System.out.println("Test:"+feeds.size());

/*
     //   ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        //Initialize notification messages for pop up Modals 1.message header 2.message body 3.message type
  //      if (message == null) { message = new ArrayList<String>();  message.add(""); message.add(""); message.add(""); }
        String titleSearch = request.getParameter("titleSearch"); if (titleSearch == null) titleSearch = "";
      //  String workTypeSelection = request.getParameter("workTypeSearch");
     //   String[] workTypeSearch = controller.getWorkTypeSearch(workTypeSelection);
        String departmentSelection = request.getParameter("departmentSearch");
        String[] departmentSearch = controller.getDepartmentSearch(departmentSelection);
        //Return search results in the form of Jobs for populating the table
       // Feed[] feeds = controller.getFeeds(null,0, titleSearch, null, departmentSelection,null, "postdate", -1);
    //  LinkedList<DBObject> getFeeds(){
        LinkedList<DBObject> feeds = controller.getFeeds();

//  Job[] appliedJobs = controller.getAppliedJobs(user.getUserId());

*/
        %>
        <input type="hidden" id="modalTrigger" value="2<%//message.get(2)%>">
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
                                <a class="btn btn-secondary" data-toggle="collapse" href="#collapseSearch" aria-expanded="false" aria-controls="collapseSearch">Filter (2)</a>
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
                                        <input type="text" class="form-control" name="titleSearch" placeholder="Title" value="test ">
                                    </div>
                                </div>
                                <div class="form-row">title
                                    <div class="form-group col-md-6">
                                        <label>Department</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="All" >
                                                <label class="form-check-label">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchAdministration" value="Administration" >
                                                <label class="form-check-label">Administration</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchEnglish" value="English" >
                                                <label class="form-check-label">English</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch"  id="departmentSearchMath" value="Math" >
                                                <label class="form-check-label">Math</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchScience" value="Science" >
                                                <label class="form-check-label">Science</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchArt" value="Art" >
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
                    for (int x = 0; x < feeds.size(); x++) {
                        //*
                        
                        DBObject result = feeds.get(x);
         //*
            ObjectId feedId = (ObjectId)result.get("_id");
            int newsId = (int)result.get("newsId");
            String title = (String)result.get("title");
            String body = (String)result.get("body");
            String department = (String)result.get("department");
            Date date = (Date)result.get("postdate");
           // */
                     
                        /*
                        ObjectId feedId = currentFeed.getFeedId();
                        int newsId = currentFeed.getNewsId();
                        String title = currentFeed.getTitle();
                        String body = currentFeed.getBody();
                     //   String workType = currentJob.getWorkType();
                        String department = currentFeed.getDepartment();
                        String date = currentFeed.getPostDate().toString();
                        *//*
                        ObjectId userId = user.getUserId();
                        String firstName = user.getFirstName();
                        String lastName = user.getLastName();
                        String email = user.getEmail();
                        String phone = user.getPhone();
                        String footerLabel = controller.getFooterLabel(date);
                        */
                %>
                <br>
                <div class="card">
                    <div class="card-header float-right align-items-center py-2">
                       <div style="float: left">
                        <span class="btn-warning badge badge-pill">Test Departent</span>

                        </div>
                        <p style="float:center">Post date:2019-10-11 Author:test</p>

                    </div>
                    <div class="card-body">
                        <h4 class="card-title">testtitle</h4>
                        <p class="card-text">testbody</div>
                    <div class="card-footer text-muted">testfooter</div>
                </div>


                <%
                    }
                %>
            </div>
        </div>
        <%
            //Clear error message from Session
           // session.removeAttribute("message");
        %>

        <%@ include file="/WEB-INF/jspf/footer.jspf" %>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
   
    </body>
</html>
