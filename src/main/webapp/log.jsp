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
    </head>
    <body>
        <%//Check if there is a valid user in the session
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
        Date date = new Date();
        DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"); 
        %>
        <br><p style="text-align:right; padding-top: 100px;"> Logged on <%= dateFormat.format(date) %></p>       
  
        
        
        <%
                   AuditLogDAO auditLogDao = (AuditLogDAO)session.getAttribute("auditLogDao");
                    UserAudit[] userAudits = auditLogDao.getUserAudit();
                                for (int x = 0; x < userAudits.length; x++) {
                                    UserAudit currentLog = userAudits[x];
                                    ObjectId logId = currentLog.getLogID();
                                    String firstName = currentLog.getFirstName(); 
                                    Date loginTime = currentLog.getLoginTime();
                               
      %>

<H3 style="color:#e0ac62; padding-top: 50px;" align="center">Log Activities</H3>
<table action="LogServlet" method="post" style="padding-top: 100px;" width="600" border="1" align="center">
<tr>
    <th> <div align="center">LogID </div></th>

<th> <div align="center">Name </div></th>

<th> <div align="center">Last Logged In </div></th>
</tr>

<tr>
 <td><div align="center" value="<%=logId%>"></div></td>

<td><div align="center" value="<%=firstName%>"></div></td>

<td><div align="center" value="<%=loginTime%>"></div></td>

                    <%
                        }
                   %>
</tr>
</table> 

<form action ="logactivity.jsp" target="" method="post" style="padding-top: 100px; text-align:center;">
            <table style="margin: 0 auto; padding-top: 100px; padding-bottom: 20px; text-align: left;">              
                <H3 style="color:#e0ac62;" >Search Login Records</H3>
                <tr>
                    <th> Date: </th>
                    <th><input type="text" name="DATETIME"></th>
                </tr>
                <tr>
                    <th> userID: </th>
                    <th><input type="text" name="USERID"></th>
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
