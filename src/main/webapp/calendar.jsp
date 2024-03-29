<%-- 
    Document   : calendar
    Created on : 23/09/2019, 2:19:30 PM
    Author     : MatthewHellmich
--%>

<%@page import="uts.asd.hsms.model.User"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="uts.asd.hsms.model.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.controller.*"%>
<%@page import="java.io.*,java.lang.*,java.util.*,java.net.*,java.util.*,java.text.*"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>

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

        <title>Calendar</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "calendar");
        %>   
        <jsp:include page="LoginServlet" flush="true" />
        <%
        } else {
            if (user.getUserRole() > 5) {
                response.sendRedirect("index.jsp");
            }
        %>
        <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%            }
        %>

        <%
            CalendarController controller = new CalendarController(session);
            ArrayList<String> message = (ArrayList<String>) session.getAttribute("message");
            if (message == null) {
                message = new ArrayList<String>();
                message.add("");
                message.add("");
                message.add("");
            }
            SimpleDateFormat dayMonthYearFormat = new SimpleDateFormat("dd-MM-yyyy");
            SimpleDateFormat yearMonthDayFormat = new SimpleDateFormat("yyyy-MM-dd");
            String eventNameSearch = request.getParameter("eventNameSearch");
            if (eventNameSearch == null) {
                eventNameSearch = "";
            }
            String eventTagSelection = request.getParameter("eventTagSearch");
            String[] eventTagSearch = controller.getEventTagSearch(eventTagSelection);
            Calendar[] calendars = controller.getCalendars(null, null, eventNameSearch, null, eventTagSelection, "date", 1);

        %>

        <input type="hidden" id="modalTrigger" value="<%=message.get(2)%>">
        <div class="main">
            <div class="container">
                <h2>Calendar</h2>

                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Calendar</li>
                    </ol>
                </nav> 
                <div class="card">
                    <div class="card-header">
                        <form action="calendar.jsp" method="post">
                            <div class="float-left">
                                <a class="btn btn-secondary" data-toggle="collapse" href="#collapseSearch" aria-expanded="false" aria-controls="collapseSearch">Event Name & Tag Search (<%=calendars.length%>)</a>
                                <input type="hidden" name="dateSearch" value="">
                                <input type="hidden" name="eventNameSearch" value="">
                                <input type="hidden" name="eventTagSearch" value="">
                                <button type="submit" class="btn btn-outline-secondary">Clear Filters</button>
                            </div>
                            <div class="float-right align-items-center py-2">
                                <span>Quick Filters:</span>
                                <button id="eventTagButtonPersonal" class="btn btn-outline-info badge badge-pill" type="button">Personal</button>
                                <button id="eventTagButtonWork" class="btn btn-outline-info badge badge-pill" type="button">Work</button>
                                <button id="eventTagButtonSchool" class="btn btn-outline-info badge badge-pill" type="button">School</button>
                            </div>                            
                        </form>
                    </div>

                    <div class="collapse" id="collapseSearch">
                        <div class="card-body">
                            <form action="calendar.jsp" method="post">
                                <div class="form-row">

                                    <div class="form-group col-md-6">
                                        <label>Event Name</label>
                                        <input type="text" class="form-control" name="eventNameSearch" placeholder="Event Name" value="<%=eventNameSearch%>">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>Event Tag</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="eventTagSearch" value="All" <%=eventTagSearch[0]%>>
                                                <label class="form-check-label">All</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="eventTagSearch" id="eventTagSearchPersonal" value="Personal" <%=eventTagSearch[1]%>>
                                                <label class="form-check-label">Personal</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="eventTagSearch" id="eventTagSearchWork" value="Work" <%=eventTagSearch[2]%>>
                                                <label class="form-check-label">Work</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="eventTagSearch" id="eventTagSearchSchool" value="School" <%=eventTagSearch[3]%>>
                                                <label class="form-check-label">School</label>
                                            </div>                                             
                                        </div>
                                    </div>
                                </div> 
                                <button id="searchButton" type="submit" class="btn btn-primary mb-2">Search</button>
                            </form> 
                        </div>
                    </div>
                </div>

                <!--Populate table from Mongo DB-->
                <table class="table">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">Date</th>
                            <th scope="col">Event Name</th>
                            <th scope="col">Description</th>
                            <th scope="col">Event Tag</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < calendars.length; i++) {
                                Calendar currentCalendar = calendars[i];
                                ObjectId calendarId = currentCalendar.getCalendarId();
                                //Date date = currentCalendar.getDate();
                                String date = dayMonthYearFormat.format(currentCalendar.getDate());
                                String eventName = currentCalendar.getEventName();
                                String description = currentCalendar.getDescription();
                                String eventTag = currentCalendar.getEventTag();
                                String[] eventTagEdit = controller.getEventTagEdit(eventTag);
                        %>
                        <tr>
                            <td><%=date%></td>
                            <td><%=eventName%></td>
                            <td><%=description%></td>
                            <td><%=eventTag%></td>
                            <td>

                                <button type="button" class="btn btn-primary" id="calendarEditButton<%=i%>" data-toggle="modal" data-target="#calendarEditModal<%=i%>">Edit</button>
                                <button type="button" class="btn btn-danger"  data-toggle="modal" data-target="#calendarDeleteModal<%=i%>">Delete</button>

                                <!--EDIT-->        
                                <div class="modal fade" id="calendarEditModal<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit <%=eventName%></h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="CalendarServlet" method="post">
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Date</label>
                                                        <div class="col-sm-8 date">
                                                            <input type="date" class="form-control" name="dateEdit" placeholder="Date" value="<%=yearMonthDayFormat.format(currentCalendar.getDate())%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Event Name</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="eventNameEdit" placeholder="Event Name" value="<%=eventName%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Description</label>
                                                        <div class="col-sm-8">
                                                            <input type="tel" class="form-control" name="descriptionEdit" id="descriptionEdit<%=i%>" placeholder="Description" value="<%=description%>">
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-sm-4">Event Tag</div>
                                                        <div class="col-sm-8">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="eventTagEdit" value="Personal" <%=eventTagEdit[0]%>>
                                                                <label class="form-check-label">Personal</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="eventTagEdit" value="Work" <%=eventTagEdit[1]%>>
                                                                <label class="form-check-label">Work</label>
                                                            </div>
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="radio" name="eventTagEdit" value="School" <%=eventTagEdit[2]%>>
                                                                <label class="form-check-label">School</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="hidden" name="calendarIdEdit" value="<%=calendarId.toString()%>">
                                                        <input type="hidden" name="action" value="edit">
                                                        <input type="hidden" name="redirect" value="calendar">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary" id="calendarEditConfirmButton<%=i%>">Confirm Edit</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!--DELETE-->
                                <div class="modal fade" id="calendarDeleteModal<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Delete <%=eventName%></h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>                                            
                                            <form action="CalendarServlet" method="post">
                                                <div class="modal-body">
                                                    <p>Are you sure you want to delete this event?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="hidden" name="calendarIdDelete" value="<%=calendarId.toString()%>">        
                                                    <input type="hidden" name="action" value="delete">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary btn-danger">Delete</button>
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
                <div class="float-left">
                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#eventAddModal">Add Event</button>
                </div>

                <!--ADD-->    
                <div class="modal fade" id="eventAddModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Event</h5>
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="CalendarServlet"> 
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Date</label>
                                        <div class="col-sm-8">
                                            <input type="date" class="form-control" name="dateAdd">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Event Name</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="eventNameAdd" placeholder="Event Name">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-4 col-form-label">Description</label>
                                        <div class="col-sm-8">
                                            <input type="tel" class="form-control" name="descriptionAdd" placeholder="Description">
                                        </div>
                                    </div>                                

                                    <div class="form-group row">
                                        <div class="col-sm-4">Event Tag</div>
                                        <div class="col-sm-8">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="eventTagAdd" value="Personal" checked>
                                                <label class="form-check-label">Personal</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="eventTagAdd" value="Work">
                                                <label class="form-check-label">Work</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="eventTagAdd" value="School">
                                                <label class="form-check-label">School</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="action" value="add">                                 
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary submit">Add</button>                                        
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div> 
                </div>

                <!-- After add, edit, delete -->
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
            session.removeAttribute("message");
        %>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/calendar.js"></script>
    </body>
</html>