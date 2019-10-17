<%-- 
    Document   : complaintfill
    Created on : 16 Aug. 2019, 7:15:24 pm
    Author     : Griffin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.controller.FeedbackController"%>
<%@page import="java.io.*,java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
<%@page import="javax.activation.*,javax.mail.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.util.ArrayList"%>

<jsp:include page="ConnServlet" flush="true" />
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
        <title>Submit Complaint</title>
    </head>
    <body>
        <%
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "complaintfill");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            FeedbackController controller = new FeedbackController(session);
            ArrayList<String> message = (ArrayList<String>)session.getAttribute("message");
            //Initialise notification messages for pop up Modals 1.message ehader 2.message body 3.message type
            if (message == null) { message = new ArrayList<String>(); message.add(""); message.add(""); message.add(""); }
            
        %> 

        <div class="main">
            <div class="container">
                <h1>Submit Feedback</h1><br>
                <form id="complaintForm" action="FeedbackServlet" method="post">
                    <p>Here at High School Management High School, we are dedicated to ensuring the happiness of both our students and our staff. For this reason, we are always looking
                        for ways to improve all aspects of the school.<br>
                        If you have any issues, feedback, information, or thoughts that you feel can help better, please leave a comment below, and Susan in the admin office will escalate the comment appropriately. <br>
                        Remember, all your information is private. This is an <b>anonymous</b> feedback service, and the author of any comments cannot be traced.</p>
                    <div class="form-group">
                        <label><b>Subject header:</b></label>
                        <select class="form-control" id="commSubjectAdd commSubjectEdit"  name="commSubjectAdd" placeholder="Other">
                            <option value="Facilities">Facilities</option>
                            <option value="Management">Management</option>
                            <option value="Student Issues">Student Issues</option>
                            <option value="Harassment">Harassment</option>
                            <option value="Discrimination">Discrimination</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="form-group position-relative">
                        <label><b>Comment:</b></label>
                        <textarea name="commentAdd" class="form-control" rows="5" id="commentAdd" placeholder="Enter your comment here."></textarea>
                        <h6 class="rightalign position-absolute" id="count_message"></h6>
                    </div>
                    <div>
                        <input type="hidden" name="action" value="add">
                        <button id="checkCount" type="submit" class="btn btn-primary" data-toggle="modal" data-target="#feedbackSuccess">Submit</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!--MESSAGE MODAL for Success Feedback-->
                <div class="modal fade" id="feedbackSuccess" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h2 class="modal-title">Feedback Sent!</h2>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>  
                            

        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/complaintfill.js"></script>
    </body>
</html>
