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
                 String name = user.getFirstName();
                 
               Message[] messages = messageDao.getMessage(name);
                    for(int i = 0; i < messages.length; i++) {
                        Message message = messages[i];
                       ObjectId messageID = message.getMessageID();
                        String sender = message.getSender();
                        String recipient = message.getRecipient();
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
                 <td>Content: <%=content%></td>
             <tr>  
                <td colspan="3" align="right">              
                    <button type="button"  id="messageReplyButton<%=i%>" data-toggle="modal" data-target="#messageReplyModal<%=i%>">Reply</button>
                   <button type="button"  id="messageForwardButton<%=i%>" data-toggle="modal" data-target="#messageForwardModal<%=i%>">Forward</button>
                   <button type="button"  id="messageForwardButton<%=i%>" data-toggle="modal" data-target="#emailForwardModal<%=i%>">Forward Email</button>

                   <button type="button"  data-toggle="modal" data-target="#messageDeleteModal<%=i%>">Delete</button>
                   
                   <div class="modal fade" id="messageReplyModal<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h2 class="modal-title">Reply Message </h2>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                   
                                <div class="modal-body">
                                                <form action="MessagesServlet" method="post">
                                                    
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">From : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=sender%>
                                                        </div>
                                                    </div>
                                                     <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">On : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=date%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Content : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=content%>
                                                        </div>
                                                    </div>
                                                        <h>------------------------------------------------------</h>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">From : </label>
                                                        <div class="col-sm-8" align="left">
                                                            <%=name%>
                                                        </div>
                                                    </div>
                                                        
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Recipient : </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" size="30" name="recipient" placeholder="Recipient">
                                                        </div>
                                                    </div>
                                                        
                   
                                                     <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Content : </label>
                                                        <div class="col-sm-8">
                                                            <textarea rows="10" cols="30"  name="content" placeholder="Content"></textarea>
                                                        </div>
                                                    </div>
                   
                                            <div class="modal-footer">
                                                        <input type="hidden" name="messageID" value="<%=messageID%>">        
                                                        <input type="hidden" name="action" value="Send">
                                                        <input type="hidden" name="redirect" value="message">
                                                        <button type="submit" id="SendConfirmButton<%=i%>">Send</button>
                                                        <button type="button"  data-dismiss="modal">Cancel</button>                                                        
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                   </div>
                  
                   <div class="modal fade" id="messageForwardModal<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h2 class="modal-title">Forward Message </h2>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="MessagesServlet" method="post">
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Forward To : </label>
                                                        <div class="col-sm-8">
                                                             <input type="text" size="30" name="recipient" placeholder="Recipient">
                                                        </div>
                                                    </div>
                                                    <h>-------------------------------------------------------</h>
                                                    <h4 align="left">Message Detail</h4>        
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">From : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=sender%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">To : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=recipient%>
                                                        </div>
                                                    </div>
                                                         <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">On : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=date%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Content :</label>
                                                        <div class="col-sm-8"  align="left">
                                                            <input type="text" name="content" placeholder="Content" value="<%=content%>">

                                                        </div>
                                                    </div>   
                                                  <div class="modal-footer">
                                                        <input type="hidden" name="messageID" value="<%=messageID%>">        
                                                        <input type="hidden" name="action" value="Forward">
                                                        <input type="hidden" name="redirect" value="message">
                                                        <button type="submit" id="forwardConfirmButton<%=i%>">Forward Message</button>
                                                        <button type="button"  data-dismiss="modal">Cancel</button>                                                       
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                   </div>
                   <div class="modal fade" id="emailForwardModal<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h2 class="modal-title">Forward Email </h2>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="MessagesServlet" method="post">
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Forward To : </label>
                                                        <div class="col-sm-8">
                                                             <input type="text" size="30" name="recipient" placeholder="Recipient">
                                                        </div>
                                                    </div>
                                                    <h>-------------------------------------------------------</h>
                                                    <h4 align="left">Message Detail</h4>        
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">From : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=sender%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">To : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=recipient%>
                                                        </div>
                                                    </div>
                                                         <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">On : </label>
                                                        <div class="col-sm-8"  align="left">
                                                            <%=date%>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-4 col-form-label">Content :</label>
                                                        <div class="col-sm-8"  align="left">
                                                            <input type="text" name="content" placeholder="Content" value="<%=content%>">

                                                        </div>
                                                    </div>   
                                                  <div class="modal-footer">
                                                        <input type="hidden" name="messageID" value="<%=messageID%>">        
                                                        <input type="hidden" name="action" value="ForwardEmail">
                                                        <input type="hidden" name="redirect" value="message">
                                                        <button type="submit" id="forwardConfirmButton<%=i%>">Forward Email</button>
                                                        <button type="button"  data-dismiss="modal">Cancel</button>                                                       
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                   </div>                                     
                   <div class="modal fade" id="messageDeleteModal<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="messageDeleteModalLabel<%=i%>">Delete Message</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>                                            
                                            <form action="MessagesServlet" method="post">
                                                <div class="modal-body">
                                                    <p>Do you want to delete this message ?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="hidden" name="messageID" value="<%=messageID%>">        
                                                    <input type="hidden" name="action" value="Delete">
                                                     <input type="hidden" name="redirect" value="message">
                                                        <button type="submit" id="deleteConfirmButton<%=i%>">Delete</button>
                                                    <button type="button" data-dismiss="modal">Close</button>
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
        </tr>
          </table>
      </form>
        
         <%@ include file="/WEB-INF/jspf/footer.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
