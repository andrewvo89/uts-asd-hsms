<%-- 
    Document   : complaintbacklog
    Created on : 16 Aug. 2019, 9:28:17 pm
    Author     : Griffin
--%>

<%@page import="uts.asd.hsms.controller.*"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
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
        <title>Complaint Backlog</title>
    </head>
    <body>
        
        <%
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "complaintbacklog");
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
            FeedbackController controllerc = new FeedbackController(session);
            SimpleDateFormat dayDateFormat = new SimpleDateFormat("dd-MM-yyyy");
            ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
            //Initialise notification messages for pop up Modals 1.message ehader 2.message body 3.message type
            if (message == null) { message = new ArrayList<String>(); message.add(""); message.add(""); message.add(""); }
            //Prefill Search variables
            Feedback[] feedbacks = controllerc.getFeedback(null, 0, null, null, null, null, null, "commentId", 1);
        %> 
        
        <div class="main">
            <div class="container">
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Complaint Backlog</li>
                    </ol>
                </nav>
                
                <h1>Feedback Backlog</h1>
                
                <!-- Modal Filter Section 
                <div class="card" style="margin-top:25px">
                    <div class="card-header">
                        <button type="button" class="btn btn-secondary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample" data-toggle="button">Filter</button>
                    </div>
                    <div class="collapse" id="collapseExample">
                        <div class="card-body">
                            <form action="">
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <label for="firstName">Key Word</label>
                                    <input type="text" class="form-control" id="classId" placeholder="Key Word">
                                </div>
                            </div>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <div class="form-group">
                                            <label for="sell"><b>Subject</b></label>
                                                <select class="form-control" id="sell">
                                                    <option>Facilities</option>
                                                    <option>Management</option>
                                                    <option>Student Issues</option>
                                                    <option>Harassment</option>
                                                    <option>Discrimination</option>
                                                    <option value="6">Other</option>
                                                </select>
                                        </div>
                                    </div>
                                </div> 
                                <button type="submit" class="btn btn-primary mb-2">Search</button>
                            </form> 
                     </div>
                    </div>
                </div>
                 END of Modal Filter Section -->
                <br><div>
                    <table class="table">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">Comment ID</th>
                                <th scope="col">Subject</th>
                                <th scope="col">Comment</th>
                                <th scope="col">Date</th>
                                <th scope="col">Escalated</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int x = 0; x < feedbacks.length; x++) {
                                    Feedback currentFeedback = feedbacks[x];
                                    ObjectId refCommentId = currentFeedback.getRefCommentId();
                                    int commentId = currentFeedback.getCommentId();
                                    String commSubject = currentFeedback.getCommSubject();
                                    String comment = currentFeedback.getComment();
                                    String commDate = dayDateFormat.format(currentFeedback.getCommDate());
                                    Boolean escalated = currentFeedback.getEscalated();
                                    Boolean archived = currentFeedback.getArchived();    
                            %>
                            <tr>
                                <td><%=commentId%></td>
                                <td><%=commSubject%></td>
                                <td><%=comment%></td>
                                <td><%=commDate%></td>
                                <td><%=escalated%></td>
                                <td>
                                    <form >
                                        <input type="hidden" name="refCommentId" value="<%=refCommentId%>" 
                                    </form><button type="submit" class="btn btn-outline-warning">Escalate </button>
                                </td>
                                
                            <%
                                }
                            %>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>   
        </div>
                
                
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <!--<script src="js/classrollmanagement.js"></script>-->
    </body>
</html>
