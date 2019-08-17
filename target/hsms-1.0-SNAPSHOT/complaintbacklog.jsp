<%-- 
    Document   : complaintbacklog
    Created on : 16 Aug. 2019, 9:28:17 pm
    Author     : Griffin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%
    User user = (User)session.getAttribute("user");
%>
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
        <%
        if (user == null) {
            response.sendRedirect("index.jsp?redirect=complaintbacklog");
        }
        else {
        %>
            <%@ include file="/WEB-INF/jspf/header-loggedin.jspf" %>
        <%
        }
        %>
    </head>
    <body>
        <div class="main">
            <div class="container">
                <h1>Feedback Backlog</h1>
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
                
                <br><table class="table">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">Comment ID</th>
                                <th scope="col">Subject</th>
                                <th scope="col">Comment</th>
                                <th scope="col">Date</th>
                                <th scope="col">Escalated</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Facilities</td>
                                <td>The toilets are filthy. Students have kept complaining to me how there are wet toilet paper balls all over the place. Put more funds into janitors please!</td>
                                <td>17/8/2019</td>
                                <td>
                                    <select class="form-control" id="escalate">
                                        <option>Yes</option>
                                        <option>Under Revision</option>
                                        <option selected>No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Discrimination</td>
                                <td>I can't stand this anymore. The students keep calling me names like "Moor" and "Donkey". If I hear anymore of this I'll go mad. - Othello</td>
                                <td>17/3/1456</td>
                                <td>
                                    <select class="form-control" id="escalate">
                                        <option>Yes</option>
                                        <option>Ongoing</option>
                                        <option selected>No</option>
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                
            </div>        
                
                
        <%@ include file="/WEB-INF/jspf/footer-static.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
