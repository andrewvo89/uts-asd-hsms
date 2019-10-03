<%-- 
    Document   : messageview
    Created on : Sep 20, 2019, 6:37:18 PM
    Author     : Sukonrat
--%>

<%@page import="java.util.Date"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.model.Message"%>
<%@page import="uts.asd.hsms.model.dao.MessageDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Message View</title>
        <%-- //Check if there is a valid user in the session
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
        --%> 
    </head>
    <body>
        <h3>Messages</h3>
      
        <table>  
            <tr>
                <td>Recipient: <td>
                <td>Message Title: </td>
                <td>Message Description: </td>
                <td>Date: </td>
            </tr>
        <%--
            
           MessageDao messageDao = (MessageDao)session.getAttribute("messageDao");
                    Message[] messages = messageDao.getMessage();
                      for (int x = 0; x < messages.length; x++) {
                       Message message = messages[x];
                                ObjectId messageID = message.getMessageID();
                                String recipient = message.getRecipient();
                                String title =  message.getTitle();
                                String description = message.getContent();
                                Date date = message.getCreateDate();
                          
 --%>
       
  <tr>
      <td><%--=recipient--%></td>
      <td><%--=title--%></td>
      <td><%--=description--%></td>
      <td><%--=date--%></td>  
     
      
        <%--
            }
        --%>
        </tr>
        </table>  
        
    <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
