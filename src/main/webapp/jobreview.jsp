<%-- 
    Document   : jobreview
    Created on : 10 Sep. 2019, 1:01:19 pm
    Author     : Andrew
--%>

<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="uts.asd.hsms.controller.JobReviewController"%>
<%@page import="org.bson.types.ObjectId"%>
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
            User user = (User) session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "jobreview");
        %>   
        <jsp:include page="LoginServlet" flush="true" />
        <%
        } else {//Only Administrator & Principal Access
            if (user.getUserRole() > 2 || request.getParameter("jobId") == null) %><jsp:include page="LoginDeniedServlet" flush="true" />        
        <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%            
            }
            JobReviewController controller = new JobReviewController(session);
            ArrayList<String> message = (ArrayList<String>) session.getAttribute("message");
            //Initialize notification messages for pop up Modals 1.message header 2.message body 3.message type
            if (message == null) {
                message = new ArrayList<String>();
                message.add("");
                message.add("");
                message.add("");
            }
            ObjectId jobId = new ObjectId(request.getParameter("jobId"));//Jobid from jobmanagement.jsp
            Job job = controller.getJobs(jobId, null, null, null, null, null, null, null, true, "title", 1)[0];
            JobApplication[] jobApplications = controller.getJobApplications(null, jobId, null, null, null, "statusdate", -1);
        %>
        <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
        <div class="main">
            <div class="container">
                <h2><%=job.getTitle()%></h2>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="jobmanagement.jsp">Job Management</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Job Review</li>
                    </ol>
                </nav>
                <%
                    //Loop through results of MongoDB search result and place them in a table
                    for (int x = 0; x < jobApplications.length; x++) {
                        ObjectId jobApplicationId = jobApplications[x].getJobApplicationId();
                        ObjectId userId = jobApplications[x].getUserId();
                        User currentUser = controller.getUsers(userId, null, null, null, null, null, null, null, 0, null, "firstname", 1)[0];
                        String firstName = currentUser.getFirstName();
                        String lastname = currentUser.getLastName();
                        String email = currentUser.getEmail();
                        String phone = currentUser.getPhone();
                        String location = currentUser.getLocation();
                        String coverLetter = controller.processLineBreaks(jobApplications[x].getCoverLetter());
                        BasicDBObject status = jobApplications[x].getStatus();
                        String currentStatusString = (String) controller.getCurrentStatusStringDate(status).get(0);
                        Date currentStatusDate = (Date) controller.getCurrentStatusStringDate(status).get(1);
                        String[] statusButtonOutline = controller.getStatusOutline(status);
                        String[] statusButtonLabel = controller.getStatusButtonLabel(status);
                        String[] statusButtonToggle = controller.getStatusButtonToggle(status);
                        String footerLabel = controller.getFooterLabel(currentStatusString, currentStatusDate);
                %>
                <div class="card">              
                    <div class="card-header float-right align-items-center py-2">
                        <span class="btn-success badge badge-pill"><%=location%></span>
                        <span class="btn-info badge badge-pill"><%=email%></span>
                        <span class="btn-warning badge badge-pill"><%=phone%></span>
                    </div>
                    <div class="card-body">
                        <h4 class="card-title"><%=firstName%> <%=lastname%></h4>
                        <p class="card-text"><%=coverLetter%></p>
                        <button type="button" class="btn btn<%=statusButtonOutline[0]%>-primary" disabled><%=statusButtonLabel[0]%></button>
                        <strong>>></strong>
                        <button type="button" class="btn btn<%=statusButtonOutline[1]%>-warning" data-toggle="<%=statusButtonToggle[1]%>" data-target="#reviewModal<%=x%>"><%=statusButtonLabel[1]%></button>
                        <strong>>></strong>
                        <button type="button" class="btn btn<%=statusButtonOutline[2]%>-danger" data-toggle="<%=statusButtonToggle[2]%>" data-target="#rejectModal<%=x%>"><%=statusButtonLabel[2]%></button>
                        <strong>>></strong>
                        <button type="button" class="btn btn<%=statusButtonOutline[3]%>-success" data-toggle="<%=statusButtonToggle[3]%>" data-target="#successModal<%=x%>" id="successButton<%=x%>"><%=statusButtonLabel[3]%></button>
                    </div>
                    <div class="card-footer text-muted"><%=footerLabel%></div>
                </div>
                <br>
                <!--UNDER REVIEW CONFIRMATION MODAL-->                          
                <div class="modal fade" id="reviewModal<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Acknowledge Applicant</h5>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>                                            
                            <form action="JobReviewServlet" method="post" class="inline-form">
                                <div class="modal-body">
                                    <p>Acknowledge <b><%=currentUser.getFirstName()%> <%=currentUser.getLastName()%>'s</b> job application and put it under review?</p>
                                    <p><b><%=currentUser.getFirstName()%> <%=currentUser.getLastName()%></b> will be notified by email: <b><%=currentUser.getEmail()%></b></p>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="jobApplicationId" value="<%=jobApplicationId%>">
                                    <input type="hidden" name="action" value="review">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>                 
                                    <button type="submit" class="btn btn-primary btn-warning">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!--REJECT CONFIRMATION MODAL-->                          
                <div class="modal fade" id="rejectModal<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Reject Applicant</h5>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>                                            
                            <form action="JobReviewServlet" method="post" class="inline-form">
                                <div class="modal-body">
                                    <p>Are you sure you want to reject <b><%=currentUser.getFirstName()%> <%=currentUser.getLastName()%>'s</b> job application?</p>
                                    <p><b><%=currentUser.getFirstName()%> <%=currentUser.getLastName()%></b> will be notified by email: <b><%=currentUser.getEmail()%></b></p>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="jobApplicationId" value="<%=jobApplicationId%>">
                                    <input type="hidden" name="action" value="reject">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>                 
                                    <button type="submit" class="btn btn-primary btn-danger">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!--SUCCESSFUL CONFIRMATION MODAL-->                          
                <div class="modal fade" id="successModal<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="jobDeleteModalLabel<%=x%>">Successful Applicant</h5>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>                                            
                            <form action="JobReviewServlet" method="post" class="inline-form">
                                <div class="modal-body">
                                    <p>Are you sure <b><%=currentUser.getFirstName()%> <%=currentUser.getLastName()%></b> is the successful applicant?</p>
                                    <p>This job post's status will be marked as <b>Closed</b></p>
                                    <p><b><%=currentUser.getFirstName()%> <%=currentUser.getLastName()%></b> will be notified by email: <b><%=currentUser.getEmail()%></b></p>
                                    <p>All other job application's status will be marked as <b>Rejected</b> and notified by email</p>
                                </div>
                                <div class="modal-footer">
                                    <input type="hidden" name="jobApplicationId" value="<%=jobApplicationId%>">
                                    <input type="hidden" name="action" value="success">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>                 
                                    <button type="submit" id="successConfirmButton<%=x%>" class="btn btn-primary btn-success">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <%
                    }
                %>
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
        <script src="js/jobreview.js"></script>
    </body>
</html>
