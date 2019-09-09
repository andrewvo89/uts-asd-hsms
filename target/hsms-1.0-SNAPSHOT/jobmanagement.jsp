<%-- 
    Document   : jobboard
    Created on : 06 Sep. 2019, 5:53:34 pm
    Author     : Andrew
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.asd.hsms.model.dao.JobDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="ConnServlet" flush="true" />
<%@page import="uts.asd.hsms.model.*"%>
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
        <title>Job Board</title>
        <%//Check if there is a valid user in the session
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "jobmanagement");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
        %> 
    </head>
    <%
        JobDao jobDao = (JobDao)session.getAttribute("jobDao");
        SimpleDateFormat ddMMyyyy = new SimpleDateFormat("dd-MM-yyyy"); 
        SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyy-MM-dd");   
        ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        if (message == null) {//Initialize notification messages for pop up Modals
            message = new ArrayList<String>();//1.message header 2.message body 3.message type
            message.add(""); message.add(""); message.add("");
        }
        
        //Prefill Search Data variables
        String titleSearch = request.getParameter("titleSearch"); if (titleSearch == null) titleSearch = ""; 
        String workTypeSearch = request.getParameter("workTypeSearch"); if (workTypeSearch == null) workTypeSearch = ""; 
        String departmentSearch = request.getParameter("departmentSearch"); if (departmentSearch == null) departmentSearch = "";
        String statusSearch = request.getParameter("statusSearch"); if (statusSearch == null) statusSearch = "";
        String workTypeSearchAll="", workTypeSearchFullTime="", workTypeSearchPartTime="", workTypeSearchCasual="", workTypeSearchContract="";
        String departmentSearchAll="", departmentSearchAdministration="", departmentSearchEnglish="", departmentSearchMath="", departmentSearchScience="", departmentSearchArt="";
        String statusSearchAll="", statusSearchDraft="", statusSearchOpen="", statusSearchClosed="";

           
        if (workTypeSearch.equals("Full Time")) workTypeSearchFullTime = "checked";
        else if(workTypeSearch.equals("Part Time")) workTypeSearchPartTime = "checked";
        else if(workTypeSearch.equals("Casual")) workTypeSearchCasual = "checked";
        else if(workTypeSearch.equals("Contract")) workTypeSearchContract = "checked";
        else workTypeSearchAll = "checked";
        if (departmentSearch.equals("English")) departmentSearchEnglish = "checked";
        else if(departmentSearch.equals("Math")) departmentSearchMath = "checked";
        else if(departmentSearch.equals("Science")) departmentSearchScience = "checked";
        else if(departmentSearch.equals("Art")) departmentSearchArt = "checked";
        else if(departmentSearch.equals("Administration")) departmentSearchAdministration = "checked";
        else departmentSearchAll = "checked";
        if (statusSearch.equals("Draft")) statusSearchDraft = "checked";
        else if (statusSearch.equals("Open")) statusSearchOpen = "checked";
        else if(statusSearch.equals("Closed")) statusSearchClosed = "checked";
        else statusSearchAll = "checked";
        //Return search results in the form of Users for populating the table
        Job[] jobs = jobDao.getJobs(null, titleSearch, null, workTypeSearch, departmentSearch, statusSearch, null, null);
        int jobsCount = jobs.length;
    %>
    <body>
        <div class="main">
            <div class="container">
                <h2>Job Board</h2>
                <div class="card" style="margin-top:25px">
                    <div class="card-header">
                        <form action="jobmanagement.jsp" method="post">
                            <div class="float-left">
                                <button type="button" class="btn btn-secondary" data-toggle="collapse" href="#collapseSearch" role="button" aria-expanded="false" aria-controls="collapseExample" data-toggle="button">Filter (<%=jobsCount%>)</button>
                                <input type="hidden" name="titleSearch" value="">
                                <input type="hidden" name="workTypeSearch" value="">
                                <input type="hidden" name="departmentSearch" value="">
                                <input type="hidden" name="statusSearch" value="">
                                <button type="submit" class="btn btn-outline-secondary">Clear Filter</button>
                            </div>
                            <div class="float-right align-items-center py-2">
                                <span>Quick Filters:</span>
                                <button id="statusButtonDraft" class="btn btn-outline-success badge badge-pill" type="button">Draft</button>
                                <button id="statusButtonOpen" class="btn btn-outline-success badge badge-pill" type="button">Open</button>
                                <button id="statusButtonClosed" class="btn btn-outline-success badge badge-pill" type="button">Closed</button>
                                <button id="workTypeButtonFullTime" class="btn btn-outline-primary badge badge-pill" type="button">Full Time</button>
                                <button id="workTypeButtonPartTime" class="btn btn-outline-primary badge badge-pill" type="button">Part Time</button>
                                <button id="workTypeButtonCasual" class="btn btn-outline-primary badge badge-pill" type="button">Casual</button>
                                <button id="workTypeButtonContract" class="btn btn-outline-primary badge badge-pill" type="button">Contract</button>
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
                            <form action="jobmanagement.jsp" method="post">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="titleSearch">Title</label>
                                        <input type="text" class="form-control" name="titleSearch" placeholder="Title" value="<%=titleSearch%>">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="departmant">Status</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="All" <%=statusSearchAll%>>
                                                <label class="form-check-label">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="Draft" id="statusSearchDraft" <%=statusSearchDraft%>>
                                                <label class="form-check-label">Draft</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="Open" id="statusSearchOpen" <%=statusSearchOpen%>>
                                                <label class="form-check-label">Open</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="Closed" id="statusSearchClosed" <%=statusSearchClosed%>>
                                                <label class="form-check-label">Closed</label>
                                            </div>                                              
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="workTypeSearch">Work Type</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" value="All" <%=workTypeSearchAll%>>
                                                <label class="form-check-label">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchFullTime" value="Full Time" <%=workTypeSearchFullTime%>>
                                                <label class="form-check-label">Full Time</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchPartTime" value="Part Time" <%=workTypeSearchPartTime%>>
                                                <label class="form-check-label">Part Time</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchCasual" value="Casual" <%=workTypeSearchCasual%>>
                                                <label class="form-check-label">Casual</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchContract" value="Contract" <%=workTypeSearchContract%>>
                                                <label class="form-check-label">Contract</label>
                                            </div>                                               
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="departmentSearch">Department</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" value="All" <%=departmentSearchAll%>>
                                                <label class="form-check-label">All</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchAdministration" value="Administration" <%=departmentSearchAdministration%>>
                                                <label class="form-check-label">Administration</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchEnglish" value="English" <%=departmentSearchEnglish%>>
                                                <label class="form-check-label">English</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch"  id="departmentSearchMath" value="Math" <%=departmentSearchMath%>>
                                                <label class="form-check-label">Math</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchScience" value="Science" <%=departmentSearchScience%>>
                                                <label class="form-check-label">Science</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="departmentSearch" id="departmentSearchArt" value="Art" <%=departmentSearchArt%>>
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

                <table class="table">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">Title</th>
                            <th scope="col">Description</th>
                            <th scope="col">Work Type</th>
                            <th scope="col">Department</th>
                            <th scope="col">Status</th>
                            <th scope="col">Post Date</th>
                            <th scope="col">Close Date</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            //Loop through results of MongoDB search result and place them in a table
                            for (int x = 0; x < jobs.length; x++) {
                                Job currentJob = jobs[x];
                                String jobId = currentJob.getJobId().toString();
                                String title = currentJob.getTitle();
                                String description = currentJob.getDescription();
                                String workType = currentJob.getWorkType();
                                String department = currentJob.getDepartment();
                                String status = currentJob.getStatus();
                                String postDate = ddMMyyyy.format(currentJob.getPostDate());
                                String closeDate = ddMMyyyy.format(currentJob.getCloseDate());
                        %>
                        <tr>
                            <td><%=title%></td>
                            <td><%=description.substring(0, 20).concat("...")%></td>
                            <td><%=workType%></td>
                            <td><%=department%></td>
                            <td><%=status%></td>
                            <td><%=postDate%></td>
                            <td><%=closeDate%></td>
                            <td>                                
                                <button type=button" class="btn btn-info">Review</button>
                                <button id="jobEditButton" type="button" class="btn btn-primary" data-toggle="modal" data-target="#jobEditModal" role="button"
                                        data-jobid="<%=jobId%>" data-title="<%=title%>" data-worktype="<%=workType%>"
                                        data-department="<%=department%>" data-status="<%=status%>" data-closedate="<%=yyyyMMdd.format(currentJob.getCloseDate())%>">Edit</button>
                                <!--EDIT USER MODAL DIALOG-->        
                                <div class="modal fade" id="jobEditModal" tabindex="-1" role="dialog" aria-labelledby="jobEditModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="jobEditModalLabel"></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="JobServlet" method="post">
                                                    <div class="form-group row">
                                                        <label for="titleEdit" class="col-sm-4 col-form-label">Title</label>
                                                        <div class="col-sm-8 title">
                                                            <input type="text" class="form-control" name="titleEdit" placeholder="Title">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="descriptionEdit" class="col-sm-4 col-form-label">Description</label>
                                                        <div class="col-sm-8 description">
                                                            <textarea class="form-control" name="descriptionEdit" rows="5" placeholder="Description"><%=description%></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-4">Work Type</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" id="Full Time" value="Full Time">
                                                                <label class="form-check-label">Full Time</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" id="Part Time" value="Part Time">
                                                                <label class="form-check-label">Part Time</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" id="Casual" value="Casual">
                                                                <label class="form-check-label">Casual</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" id="Contract" value="Contract">
                                                                <label class="form-check-label">Contract</label>
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
                                                        <legend class="col-form-label col-sm-4 pt-0">Status</legend>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="statusEdit" id="Draft" value="Draft">
                                                                <label class="form-check-label">Draft</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="statusEdit" id="Open" value="Open">
                                                                <label class="form-check-label">Open</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="statusEdit" id="Closed" value="Closed">
                                                                <label class="form-check-label">Closed</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="closeDateEdit" class="col-sm-4 col-form-label">Close Date</label>
                                                        <div class="col-sm-8 closedate">
                                                            <input type="date" class="form-control" name="closeDateEdit">
                                                        </div>
                                                    </div>
                                                    <div class="jobId">
                                                        <input type="hidden" name="jobIdEdit">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="hidden" name="action" value="edit">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button id="jobEditConfirmButton" type="submit" class="btn btn-primary">Confirm</button>
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
                                <button type=button" class="btn btn-danger"  data-toggle="modal" data-target="#jobDeleteModal"
                                        data-toggle="modal"role="button" data-jobid="<%=jobId%>" data-title="<%=title%>">Delete</button>                                
                                <div class="modal fade" id="jobDeleteModal" tabindex="-1" role="dialog" aria-labelledby="jobDeleteModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="jobDeleteModalLabel"></h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>                                            
                                            <form action="JobServlet" method="post">
                                                <div class="modal-body">
                                                    <p>Are you sure you want to delete this Job Post?</p>
                                                    <p>This action cannot be undone.</p>
                                                </div>
                                                <div class="jobId">
                                                    <input type="hidden" name="jobIdDelete">        
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
                        </tr>
                            <%
                                }
                            %>
                    </tbody>
                </table>   
                <div class="float-right">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#jobAddModal" role="button" data-closedate="<%=yyyyMMdd.format(new Date())%>">Add Job Post</button>
                </div>                
                <!--ADD USER MODAL DIALOG-->   
                <div class="modal fade" id="jobAddModal" tabindex="-1" role="dialog" aria-labelledby="jobAddModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="jobAddModalLabel">Add Job Post</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="JobServlet"> 
                                    <div class="form-group row">
                                        <label for="titleAdd" class="col-sm-4 col-form-label">Title</label>
                                        <div class="col-sm-8 firstName">
                                            <input type="text" class="form-control" name="titleAdd" placeholder="Title">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="descriptionAdd" class="col-sm-4 col-form-label">Description</label>
                                        <div class="col-sm-8 description">
                                            <textarea class="form-control" name="descriptionAdd" rows="5" placeholder="Description"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-4">Work Type</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" id="Full Time" value="Full Time" checked>
                                                <label class="form-check-label">Full Time</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" id="Part Time" value="Part Time">
                                                <label class="form-check-label">Part Time</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" id="Casual" value="Casual">
                                                <label class="form-check-label">Casual</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" id="Contract" value="Contract">
                                                <label class="form-check-label">Contract</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-4">Department</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Administration" value="Administration" checked>
                                                <label class="form-check-label">Administration</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" id="English" value="English">
                                                <label class="form-check-label">English</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Math" value="Math" >
                                                <label class="form-check-label">Math</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Science" value="Science">
                                                <label class="form-check-label">Science</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" id="Art" value="Art">
                                                <label class="form-check-labe">Art</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <legend class="col-form-label col-sm-4 pt-0">Status</legend>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="statusAdd" id="Draft" value="Draft" checked>
                                                <label class="form-check-label">Draft</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="statusAdd" id="Open" value="Open">
                                                <label class="form-check-label">Open</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="statusAdd" id="Closed" value="Closed">
                                                <label class="form-check-label">Closed</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="closeDateAdd" class="col-sm-4 col-form-label">Close Date</label>
                                        <div class="col-sm-8 closedate">
                                            <input type="date" class="form-control" name="closeDateAdd">
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
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/jobmanagement.js"></script>
    </body>
</html>