<%-- 
    Document   : jobreview
    Created on : 10 Sep. 2019, 1:01:19 pm
    Author     : Andrew
--%>

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
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "jobboard");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {//Only Administrator & Principal Access
                if (user.getUserRole() > 2) response.sendRedirect("index.jsp");
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
            JobReviewController controller = new JobReviewController(session);
            SimpleDateFormat longDate = new SimpleDateFormat("d MMMM"); 
            ObjectId jobId = new ObjectId(request.getParameter("jobid"));//Jobid from jobmanagement.jsp
            Job job = controller.getJobs(jobId, null, null, null, null, null, null, null, "title", 1)[0];
            JobApplication[] jobApplications = controller.getJobApplications(null, jobId, null, null, null, null, "statusdate", -1);
        %>
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
                    for (JobApplication jobApplication : jobApplications) {
                        ObjectId userId = jobApplication.getUserId();
                        User currentUser = controller.getUsers(userId, null, null, null, null, null, null, null, 0, "firstname", 1)[0];
                        String firstName = currentUser.getFirstName();
                        String lastname = currentUser.getLastName();
                        String email = currentUser.getEmail();
                        String phone = currentUser.getPhone();
                        String location = currentUser.getLocation();
                        String coverLetter = jobApplication.getCoverLetter();
                        String status = jobApplication.getStatus();
                        Date statusDate = jobApplication.getStatusDate();
                        String[] statusButtonDisabled = controller.getStatusButtonDisabled(status);
                        String[] statusButtonLabel = controller.getStatusButtonLabel(status, statusDate);
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
                        <button type="button" class="btn btn-primary" <%=statusButtonDisabled[0]%>><%=statusButtonLabel[0]%></button>>>
                        <button type="button" class="btn btn-warning" <%=statusButtonDisabled[1]%>><%=statusButtonLabel[1]%></button>>>
                        <button type="button" class="btn btn-danger" <%=statusButtonDisabled[2]%>><%=statusButtonLabel[2]%></button>>>
                        <button type="button" class="btn btn-success" <%=statusButtonDisabled[3]%>><%=statusButtonLabel[3]%></button>
                    </div>
                        <div class="card-footer text-muted"><%=status%> on <%=longDate.format(statusDate)%></div>
                </div>
                <br>
                <%        
                    }
                %>
                
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
