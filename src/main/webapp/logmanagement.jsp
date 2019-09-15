<%-- 
    Document   : log
    Created on : Aug 16, 2019, 9:30:37 PM
    Author     : Sukonrat
--%>
<%@page import="java.util.Date"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.model.dao.AuditLogDAO"%>
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
        <title>Log Management</title>
        <%//Check if there is a valid user in the session
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "logmanagement");
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
        %> 
    </head>
    
    <body>
<H3 style="color:#e0ac62; padding-top: 100px;" align="center">Log Activities</H3>
<table style="padding-top: 250px;" width="600" border="1" align="center">
<tr>
    <th><div align="center">LogID </div></th>
<th><div align="center">UserName</div></th>
<th><div align="center">Last LoggedIn</div></th>
</tr>
    <% 
            
            AuditLogDAO auditLogDao = (AuditLogDAO)session.getAttribute("auditLogDao");
                    UserAudit[] userAudits = auditLogDao.getUserAudit();
                          for (int x = 0; x < userAudits.length; x++) {
                          UserAudit currentLog = userAudits[x];
                                ObjectId logID = currentLog.getLogID();
                                String firstName =  currentLog.getFirstName();
                                Date loginTime = currentLog.getLoginTime();
                          
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
        <br><p style="text-align:center;">  USER LOGS 
            <a href="log.jsp"><button type="button"> View </button></p></a>
    <br>
 
    
</table>  
        
          <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
