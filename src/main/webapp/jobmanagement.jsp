<%-- 
    Document   : jobmanagement
    Created on : 06 Sep. 2019, 5:53:34 pm
    Author     : Andrew
--%>

<%@page import="uts.asd.hsms.controller.JobManagementController"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.asd.hsms.model.dao.JobDao"%>
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
        <title>Job Management</title>
    </head>
    <body>
    <%//Check if there is a valid user in the session
        User user = (User)session.getAttribute("user");
        if (user == null) {
            session.setAttribute("redirect", "jobmanagement");
    %>   
            <jsp:include page="LoginServlet" flush="true" />
    <%
        }
        else {//Only Administrator & Principal Access
            if (user.getUserRole() > 2) %><jsp:include page="LoginDeniedServlet" flush="true" />
            <%@ include file="/WEB-INF/jspf/header.jspf"%>
    <%
        }
        JobManagementController controller = new JobManagementController(session);
        SimpleDateFormat dayDateFormat = new SimpleDateFormat("dd-MM-yyyy"); 
        SimpleDateFormat yearDateFormat = new SimpleDateFormat("yyyy-MM-dd");   
        ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
        //Initialize notification messages for pop up Modals 1.message header 2.message body 3.message type
        if (message == null) { message = new ArrayList<String>();  message.add(""); message.add(""); message.add(""); }   
        String jobIdResult = (String)session.getAttribute("jobIdResult");
        //Prefill Search Data variables
        ObjectId jobIdSearch = null; if (request.getParameter("jobIdSearch") != null) jobIdSearch = new ObjectId(request.getParameter("jobIdSearch"));
        String titleSearch = request.getParameter("titleSearch"); if (titleSearch == null) titleSearch = ""; 
        String workTypeSelection = request.getParameter("workTypeSearch");
        String[] workTypeSearch = controller.getWorkTypeSearch(workTypeSelection);
        String departmentSelection = request.getParameter("departmentSearch");
        String[] departmentSearch = controller.getDepartmentSearch(departmentSelection);
        String statusSelection = request.getParameter("statusSearch");
        String[] statusSearch = controller.getStatusSearch(statusSelection);
        //Set any job applications past the close date to "Closed" status
        controller.setClosedStatus();
        //Return search results in the form of Job for populating the table
        Job[] jobs = controller.getJobs(jobIdSearch, titleSearch, null, workTypeSelection, departmentSelection, statusSelection, null, null, true, "title", 1);
    %>
        <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
        <input type="hidden" id="jobIdResult" value="<%=jobIdResult%>">
        <div class="main">
            <div class="container">
                <h2>Job Management</h2>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Job Management</li>
                    </ol>
                </nav>
                <div class="card">
                    <div class="card-header">
                        <form action="jobmanagement.jsp" method="post">
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
                                <button id="statusButtonDraft" class="btn btn-outline-success badge badge-pill" type="button">Draft</button>
                                <button id="statusButtonOpen" class="btn btn-outline-success badge badge-pill" type="button">Open</button>
                                <button id="statusButtonClosed" class="btn btn-outline-success badge badge-pill" type="button">Closed</button>
                                <button id="workTypeButtonFullTime" class="btn btn-outline-info badge badge-pill" type="button">Full Time</button>
                                <button id="workTypeButtonPartTime" class="btn btn-outline-info badge badge-pill" type="button">Part Time</button>
                                <button id="workTypeButtonCasual" class="btn btn-outline-info badge badge-pill" type="button">Casual</button>
                                <button id="workTypeButtonContract" class="btn btn-outline-info badge badge-pill" type="button">Contract</button>
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
                                        <label>Title</label>
                                        <input type="text" class="form-control" name="titleSearch" placeholder="Title" value="<%=titleSearch%>">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Status</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="All" <%=statusSearch[0]%>>
                                                <label class="form-check-label">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="Draft" id="statusSearchDraft" <%=statusSearch[1]%>>
                                                <label class="form-check-label">Draft</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="Open" id="statusSearchOpen" <%=statusSearch[2]%>>
                                                <label class="form-check-label">Open</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="statusSearch" value="Closed" id="statusSearchClosed" <%=statusSearch[3]%>>
                                                <label class="form-check-label">Closed</label>
                                            </div>                                              
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>Work Type</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" value="All" <%=workTypeSearch[0]%>>
                                                <label class="form-check-label">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchFullTime" value="Full Time" <%=workTypeSearch[1]%>>
                                                <label class="form-check-label">Full Time</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchPartTime" value="Part Time" <%=workTypeSearch[2]%>>
                                                <label class="form-check-label">Part Time</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchCasual" value="Casual" <%=workTypeSearch[3]%>>
                                                <label class="form-check-label">Casual</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="workTypeSearch" id="workTypeSearchContract" value="Contract" <%=workTypeSearch[4]%>>
                                                <label class="form-check-label">Contract</label>
                                            </div>                                               
                                        </div>
                                    </div>
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

                <table class="table">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">Title</th>
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
                                ObjectId jobId = currentJob.getJobId();
                                String jobIdString = jobId.toString();
                                String title = currentJob.getTitle();
                                String description = currentJob.getDescription();
                                String workType = currentJob.getWorkType();
                                String[] workTypeEdit = controller.getWorkTypeEdit(workType);
                                String department = currentJob.getDepartment();
                                String[] departmentEdit = controller.getDepartmentEdit(department);
                                String status = currentJob.getStatus();
                                String[] statusEdit = controller.getStatusEdit(status);
                                String postDate = dayDateFormat.format(currentJob.getPostDate());
                                String closeDate = dayDateFormat.format(currentJob.getCloseDate());
                                String reviewButtonDisabled = controller.getReviewButtonDisabled(jobId);
                                String reviewButtonLabel = controller.getReviewButtonLabel(jobId);
                        %>
                        <tr>
                            <td><%=title%></td>
                            <td><%=workType%></td>
                            <td><%=department%></td>
                            <td><%=status%></td>
                            <td><%=postDate%></td>
                            <td><%=closeDate%></td>
                            <td>
                                <form action="jobreview.jsp" method="post">
                                    <input type="hidden" name="jobId" value="<%=jobIdString%>">
                                    <button type="submit" class="btn btn-info" <%=reviewButtonDisabled%>><%=reviewButtonLabel%></button>
                                    <button type="button" class="btn btn-primary" id="jobEditButton<%=jobIdString%>" data-toggle="modal" data-target="#jobEditModal<%=jobIdString%>">Edit</button>                                
                                    <button type="button" class="btn btn-danger"  data-toggle="modal" data-target="#jobDeleteModal<%=jobIdString%>">Delete</button>      
                                </form>
                                <!--EDIT USER MODAL DIALOG-->        
                                <div class="modal fade" id="jobEditModal<%=jobIdString%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit <%=title%></h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="JobManagementServlet" method="post">
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Title</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="titleEdit" id="titleEdit<%=jobIdString%>" placeholder="Title" value="<%=title%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Description</label>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" name="descriptionEdit" rows="5" placeholder="Description"><%=description%></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-sm-4">Work Type</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" value="Full Time" <%=workTypeEdit[0]%>>
                                                                <label class="form-check-label">Full Time</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" value="Part Time" <%=workTypeEdit[1]%>>
                                                                <label class="form-check-label">Part Time</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" value="Casual" <%=workTypeEdit[2]%>>
                                                                <label class="form-check-label">Casual</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="workTypeEdit" value="Contract" <%=workTypeEdit[3]%>>
                                                                <label class="form-check-label">Contract</label>
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
                                                        <div class="col-form-label col-sm-4 pt-0">Status</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="statusEdit" value="Draft" <%=statusEdit[0]%>>
                                                                <label class="form-check-label">Draft</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="statusEdit" value="Open" <%=statusEdit[1]%>>
                                                                <label class="form-check-label">Open</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="statusEdit" value="Closed" <%=statusEdit[2]%>>
                                                                <label class="form-check-label">Closed</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Close Date</label>
                                                        <div class="col-sm-8 closedate">
                                                            <input type="date" class="form-control" name="closeDateEdit" id="closeDateEdit<%=jobIdString%>" value="<%=yearDateFormat.format(currentJob.getCloseDate())%>">
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="hidden" name="jobIdEdit" value="<%=jobIdString%>">
                                                        <input type="hidden" name="action" value="edit">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary" id="jobEditConfirmButton<%=jobIdString%>">Confirm</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>                        
                                <!--DELETE CONFIRMATION MODAL-->                          
                                <div class="modal fade" id="jobDeleteModal<%=jobIdString%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Delete <%=title%></h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>                                            
                                            <form action="JobManagementServlet" method="post">
                                                <div class="modal-body">
                                                    <p>Are you sure you want to delete this Job Post?</p>
                                                    <p>This action cannot be undone.</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="hidden" name="jobIdDelete" value="<%=jobId.toString()%>">
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
                    <button type="button" class="btn btn-success" id="jobAddButton" data-toggle="modal" data-target="#jobAddModal">Add Job Post</button>
                </div>                
                <!--ADD USER MODAL DIALOG-->   
                <div class="modal fade" id="jobAddModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Job Post</h5>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="JobManagementServlet"> 
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Title</label>
                                        <div class="col-sm-8 firstName">
                                            <input type="text" class="form-control" name="titleAdd" id="titleAdd" placeholder="Title">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Description</label>
                                        <div class="col-sm-8 description">
                                            <textarea class="form-control" name="descriptionAdd" id="descriptionAdd" rows="5" placeholder="Description"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-4">Work Type</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" value="Full Time" checked>
                                                <label class="form-check-label">Full Time</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" value="Part Time">
                                                <label class="form-check-label">Part Time</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" value="Casual">
                                                <label class="form-check-label">Casual</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="workTypeAdd" value="Contract">
                                                <label class="form-check-label">Contract</label>
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
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Math" >
                                                <label class="form-check-label">Math</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" id="departmentAddScience" value="Science">
                                                <label class="form-check-label">Science</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="departmentAdd" value="Art">
                                                <label class="form-check-labe">Art</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-form-label col-sm-4 pt-0">Status</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="statusAdd" value="Draft" checked>
                                                <label class="form-check-label">Draft</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="statusAdd" id="statusAddOpen" value="Open">
                                                <label class="form-check-label">Open</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Close Date</label>
                                        <div class="col-sm-8 closedate">
                                            <input type="date" class="form-control" name="closeDateAdd" id="closeDateAdd" value="<%=controller.getMonthDate()%>">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="action" value="add">                                 
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" id="jobAddConfirmationButton" class="btn btn-primary submit">Confirm</button>                                        
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
        <script src="js/jobmanagement.js"></script>
    </body>
</html>