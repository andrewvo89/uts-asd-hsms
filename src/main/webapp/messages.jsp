<%-- 
    Document   : messages
    Created on : Sep 20, 2019, 6:07:09 PM
    Author     : Sukonrat
--%>

<%@page import="java.util.Date"%>
<%@page import="uts.asd.hsms.model.dao.AuditLogDAO"%>
<%@page import="uts.asd.hsms.model.Message"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.controller.UserController"%>
<%@page import="uts.asd.hsms.model.*"%>
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
        <title>Messages</title>
        <% //Check if there is a valid user in the session
            User user = (User)session.getAttribute("user");
            if (user == null) {
                session.setAttribute("redirect", "messages");
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
      
        <form action="MessagesServlet" method="post">
            <caption ><h2 style="padding-top: 100px;" align="center">Messages</h2></caption>  
           <table border="0" width="70%" align="center">
            <tr>
                <td colspan="2" align="right"><input type="submit" name="action" value="New Message"/></td> 
            </tr>  
            <% 
                   MessagesDao messageDao = (MessagesDao)session.getAttribute("messageDao"); 
                 String email = user.getEmail();
                   //Message[] messages = messageDao.getMessage();
               Message[] messages = messageDao.getMessage(email);
                    for(int i = 0; i < messages.length; i++) {
                        Message message = messages[i];
                        ObjectId messageID = message.getMessageID();
                    //    String firstName = user.getFirstName();
                        String sender = message.getSender();
                        String recipient = message.getRecipient();
                        String title =  message.getTitle();
                        String content = message.getContent();
                        Date date = message.getDate();
             %>
             <tr>
                <td>From : <%=sender%></td>
              </tr>
            <tr>
               <td>To: <%=recipient%></td>
            </tr>
              <tr>
                  <td>On: <%=date%></td>
              </tr>
             <tr>
                 <td>Title: <%=title%></td>
              </tr>
             <tr>
                 <td>Content: <%=content%></td>
              <tr>
                <td colspan="3" align="right">
                    <input type="submit" name="action" value="Forward"/>
                    <input type="submit" name="action" value="Delete"/>
                </td>
            </tr>
        
        <%
            }
        
         %>
        </tr>
          </table>
      </form>
        
         <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
