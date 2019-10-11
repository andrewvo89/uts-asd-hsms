<%-- 
    Document   : viewLogs
    Created on : Aug 16, 2019, 9:11:09 PM
    Author     : Sukonrat
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.model.dao.AuditLogDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="uts.asd.hsms.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/ConnServlet" flush="true" />
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
        <title>Log</title>
<<<<<<< HEAD
<<<<<<< HEAD
    </head>
    <body>
        <%//Check if there is a valid user in the session
=======
        <%-- //Check if there is a valid user in the session
>>>>>>> 1ef0914b71f918c58fd3a42470c579c0f38c4beb
=======
    </head>
    <body>
        <%//Check if there is a valid user in the session
>>>>>>> 4d49f54f062c44e4256c0dbc4f2f8e38f19fd269
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "log");
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
        %>
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
<<<<<<< HEAD
<<<<<<< HEAD
=======
        --%> 
    </head>
    <body>
        
        
         <%
>>>>>>> 1ef0914b71f918c58fd3a42470c579c0f38c4beb
=======
>>>>>>> 4d49f54f062c44e4256c0dbc4f2f8e38f19fd269
        Date date = new Date();
        DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); 
        %>
        <br><p style="text-align:right; padding-top: 100px;"> Logged on <%= dateFormat.format(date) %></p>       
  
        
        
       

<H3 style="color:#e0ac62; padding-top: 50px;" align="center">Log Activities</H3>
<table style="padding-top: 100px;" width="600" border="1" align="center">
<tr>
    <th> <div align="center">LogID </div></th>
<th><div align="center">UserName</div></th>


<th> <div align="center">Last Logged In </div></th>
</tr>
 <% 
            
            AuditLogDAO auditLogDao = (AuditLogDAO)session.getAttribute("auditLogDao");
                    UserAudit[] userAudits = auditLogDao.getAllUserAudit();
                      for (int x = 0; x < userAudits.length; x++) {
                          UserAudit userAudit = userAudits[x];
                                ObjectId logID = userAudit.getLogID();
                                String firstName =  userAudit.getFirstName();
                                Date loginTime = userAudit.getLoginTime();
                          
      %>
<tr>
 <td><%=logID%></td>

<td><%=firstName%></td>
<td><%=loginTime%>"</td>

                    <%
                        }
                   %>
</tr>
</table> 

<form action ="logactivity.jsp" target="" method="post" style="padding-top: 100px; text-align:center;">
            <table style="margin: 0 auto; padding-top: 100px; padding-bottom: 20px; text-align: left;">              
                <H3 style="color:#e0ac62;" >Search Log Activities</H3>
                
                <tr>
                    <th> User Name: </th>
                    <th><input type="text" name="firstName"></th>
                </tr>
            </table>
            <input type="submit" value="Search">
           
            
        </form> 

    <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
