<%-- 
    Document   : messageforward
    Created on : Sep 30, 2019, 3:25:23 PM
    Author     : sukonrat
--%>

<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.model.User"%>
<%@page import="java.util.Date"%>
<%@page import="uts.asd.hsms.model.Message"%>
<%@page import="uts.asd.hsms.model.dao.MessagesDao"%>
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
        <title>Message forward form</title>
        <%//Check if there is a valid user in the session
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "messageforward"); 
        %>   
                <jsp:include page="LoginServlet" flush="true" />
        <%
            }
            else {
        %> 
                <%@ include file="/WEB-INF/jspf/header.jspf"%>
        <%
            }
        %> 
    </head>
    <body>
        <%
                MessagesDao messageDao = (MessagesDao)session.getAttribute("messageDao");
               
                    ObjectId messageID = (ObjectId)session.getAttribute("messageID");
                    String sender = user.getEmail();
                    String recipient = (String)session.getAttribute("recipient"); 
                    String title = (String)session.getAttribute("title"); 
                    String content = (String)session.getAttribute("content"); 
                    Date date = (Date)session.getAttribute("date");
                    // Message message = (Message)session.getAttribute("message");
               Message message = messageDao.getSingleMessage(messageID, sender, recipient, title, content, date); 
     
          
            %>
        
        <form action="MessagesServlet" method="post">
            
             <caption ><h2 style="padding-top: 100px;" align="center">Message Forward Form</h2></caption>     
      
             <table style="padding-top: 100px;" border="0" width="35%" align="center">
                 
           <tr>
                <td width="50%">Forward to</td>
                <td><input type="text" name="recipient" placeholder="Recipient" value="<%=recipient%>" size="50"/></td>
            </tr>      
            <tr>
                <td width="50%">From</td>
                <td><%=sender%></td>
            </tr>
            <tr>
                <td>Title  </td>
                <td><input type="text" name="title" placeholder="Title" value="<%=title%>" size="50"/></td>
            </tr>
            <tr>
                <td>Content </td>
                <td><textarea rows="10" cols="50" name="content" placeholder="Content" value="<%=content%>" ></textarea> </td>
            </tr>    
           <tr>
                <td colspan="2" align="center">
                <input type="submit" name="action" value="forward"/><input type="submit" name="action" value="cancel"/>
                </td>
            </tr>
             </table>
            
        </form>

        <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
