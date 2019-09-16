<%-- 
    Document   : jobboard
    Created on : 06 Sep. 2019, 5:53:34 pm
    Author     : Andrew
--%>

<%@page import="com.mongodb.BasicDBObject"%>
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
        <title>Job Board</title>
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
        Job[] openJobs = controller.getJobs(null, titleSearch, null, workTypeSelection, departmentSelection, "Open", null, null, "postdate", -1);
        Job[] appliedJobs = controller.getAppliedJobs(user.getUserId());
        %>
        <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
        <div class="main">
            <div class="container">
                <h1>Job Board</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Job Board</li>
                    </ol>
                </nav>                          
                <%--Collapsable Search for Open Jobs--%>            
                <div class="card">
                    <div class="card-header">
                        <form action="jobboard.jsp" method="post">
                            <div class="float-left">
                                <a class="btn btn-secondary" data-toggle="collapse" href="#collapseApplied" aria-expanded="false" aria-controls="collapseApplied">Applied Jobs (<%=appliedJobs.length%>)</a>
                                <a class="btn btn-secondary" data-toggle="collapse" href="#collapseSearch" aria-expanded="false" aria-controls="collapseSearch">Filter (<%=openJobs.length%>)</a>
                                <input type="hidden" name="titleSearch" value="">
                                <input type="hidden" name="workTypeSearch" value="">
                                <input type="hidden" name="departmentSearch" value="">
                                <input type="hidden" name="statusSearch" value="">
                                <button type="submit" class="btn btn-outline-secondary">Clear Filter</button>
                            </div>
                            <div class="float-right align-items-center py-2">
                                <span>Quick Filters:</span>
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
                            <form action="jobboard.jsp" method="post">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>Title</label>
                                        <input type="text" class="form-control" name="titleSearch" placeholder="Title" value="<%=titleSearch%>">
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
                    <!--APPLIED JOBS COLLAPSIBLE CARD-->
                    <div class="collapse" id="collapseApplied">
                        <div class="card-body" style="background-color: #eeeeee">
                            <%
                                for (int x = 0; x < appliedJobs.length; x++) {
                                    String title = appliedJobs[x].getTitle();
                                    String jobStatus = appliedJobs[x].getStatus();
                                    String jobStatusColor = controller.getJobStatusColor(jobStatus);
                                    JobApplication appliedJobApplication = controller.getJobApplications(null, appliedJobs[x].getJobId(), user.getUserId(), null, null, "_id", 1)[0];
                                    BasicDBObject appliedJobApplicationStatus = appliedJobApplication.getStatus();
                                    String coverLetter = controller.processLineBreaks(appliedJobApplication.getCoverLetter());
                                    String currentStatusString = (String) controller.getStatusStringDate(appliedJobApplicationStatus).get(0);
                                    Date currentStatusDate = (Date) controller.getStatusStringDate(appliedJobApplicationStatus).get(1);
                                    String[] statusButtonOutline = controller.getStatusButtonOutline(appliedJobApplicationStatus);
                                    String[] statusButtonLabel = controller.getStatusButtonLabel(appliedJobApplicationStatus);
                                    String statusFooterLabel = controller.getStatusFooterLabel(currentStatusString, currentStatusDate);
                            %>
                            <div class="card">                        
                                <div class="card-header float-right align-items-center py-2">
                                    <span class="btn-<%=jobStatusColor%> badge badge-pill"><%=jobStatus%></span>
                                </div>
                                <div class="card-body">
                                    <h4 class="card-title"><%=title%></h4>
                                    <p class="card-text"><%=coverLetter%></p>
                                    <form action="JobReviewServlet" method="post" class="inline-form">
                                        <button type="button" class="btn btn<%=statusButtonOutline[0]%>-primary" disabled><%=statusButtonLabel[0]%></button>
                                        <strong>>></strong>
                                    </form>
                                    <form action="JobReviewServlet" method="post" class="inline-form">
                                        <button type="button" class="btn btn<%=statusButtonOutline[1]%>-warning"><%=statusButtonLabel[1]%></button>
                                        <strong>>></strong>
                                    </form>
                                    <form action="JobReviewServlet" method="post" class="inline-form">
                                        <button type="button" class="btn btn<%=statusButtonOutline[2]%>-danger"><%=statusButtonLabel[2]%></button>
                                        <strong>>></strong>
                                    </form>
                                    <form action="JobReviewServlet" method="post" class="inline-form">
                                        <button type="button" class="btn btn<%=statusButtonOutline[3]%>-success"><%=statusButtonLabel[3]%></button>
                                    </form>                        
                                </div>
                                <div class="card-footer text-muted"><%=statusFooterLabel%></div>
                            </div>
                            <br>
                            <%
                                }
                            %>
                        </div>
                    </div>  
                </div> 
                <%
                    //Loop through results of MongoDB search result and place them in a table
                    for (int x = 0; x < openJobs.length; x++) {
                        Job currentJob = openJobs[x];
                        ObjectId jobId = currentJob.getJobId();
                        String title = currentJob.getTitle();
                        String description = controller.processLineBreaks(currentJob.getDescription());
                        String workType = currentJob.getWorkType();
                        String department = currentJob.getDepartment();
                        ObjectId userId = user.getUserId();
                        String firstName = user.getFirstName();
                        String lastName = user.getLastName();
                        String email = user.getEmail();
                        String phone = user.getPhone();
                        String buttonLabel = controller.getButtonLabel(jobId, userId);
                        String buttonColor = controller.getButtonColor(buttonLabel);
                        String buttonDisabled = controller.getButtonDisabled(buttonLabel);
                        String footerLabel = controller.getFooterLabel(currentJob.getPostDate());                        
                %>
                <br>
                <div class="card">                        
                    <div class="card-header float-right align-items-center py-2">
                        <span class="btn-info badge badge-pill"><%=workType%></span>
                        <span class="btn-warning badge badge-pill"><%=department%></span>
                    </div>
                    <div class="card-body">
                        <h4 class="card-title"><%=title%></h4>
                        <p class="card-text"><%=description%></p>
                        <button type="button" class="btn btn-<%=buttonColor%>" data-toggle="modal" data-target="#jobApplyModal<%=x%>" <%=buttonDisabled%>><%=buttonLabel%></button>
                    </div>
                    <div class="card-footer text-muted"><%=footerLabel%></div>
                </div>                
                <!--JOB APPLY MODAL DIALOG-->        
                <div class="modal fade" id="jobApplyModal<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><%=title%></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>    
                            </div>         
                            <form method="post" action="JobBoardServlet">                    
                                <div class="modal-body">
                                    <div class="form-group">
                                        <p class="font-weight-bold"><%=firstName%> <%=lastName%></p>
                                        <%=email%><br><%=phone%>
                                    </div>
                                    <hr>
                                    <div class="form-group">
                                        <p class="font-weight-bold">Cover Letter</p>
                                        <label>Briefly explain why you are suitable for this role. 
                                            Consider your relevant skills, qualifications and related experience.</label>
                                        <textarea class="form-control" name="coverLetter" rows="5"></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="userId" value="<%=userId.toString()%>">
                                    <input type="hidden" name="jobId" value="<%=jobId.toString()%>">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Apply</button>
                                </div>
                            </form> 
                       </div> 
                    </div>   
                </div>
                <%
                    }
                %>   
                <!--MESSAGE MODAL AFTER APPLYING FOR JOB-->
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
        <script src="js/jobboard.js"></script>
    </body>
</html>