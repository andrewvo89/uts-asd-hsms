/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.mail.MessagingException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.UserAudit;
import uts.asd.hsms.model.dao.AuditLogDAO;

/**
 *
 * @author Andrew
 */
public class LoginServlet extends HttpServlet {
    private LoginController controller;
    private HttpSession session;
    private HttpServletRequest request;
    private HttpServletResponse response;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.request = request;
        this.response = response;
        session = request.getSession();
        doLogin();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.request = request;
        this.response = response;
        session = request.getSession();
        controller = new LoginController(session);
        authenticateLogin();
    }
    
    protected void doLogin() throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("   <header>");
            out.println("       <nav class=\"navbar navbar-expand-md navbar-dark fixed-top bg-dark\">");
            out.println("           <div class=\"container\">");
            out.println("               <a class=\"navbar-brand\" href=\"index.jsp\"><strong style=\"font-size: 30px\">High School</strong><span style=\"font-size: 30px; font-weight: 300; color: rgba(255,255,255,0.7);\">Management System</span></a>");
            out.println("           </div>");
            out.println("       </nav>");
            out.println("   </header>");
            out.println("       <div class=\"main\" role=\"main\">");
            out.println("           <div class=\"container\">");
            out.println("               <form class=\"form-signin\" method=\"post\" action=\"LoginServlet\">");
            out.println("                   <p><img src=\"images/logo.jpg\" alt=\"HSMS Logo\" style=\"width:100%; height:100%;\" class=\"rounded mx-auto d-block\"></p>");
            out.println("                   <label class=\"sr-only\">Email address</label>");
            out.println("                   <input name=\"email\"  id=\"email\" type=\"text\" class=\"form-control\" placeholder=\"teacher@hsms.edu.au\" required autofocus>");
            out.println("                   <label class=\"sr-only\">Password</label>");
            out.println("                   <input name=\"password\" id=\"password\" type=\"password\" class=\"form-control pwd\" placeholder=\"password\" required>");
            out.println("                   <button name=\"submit\" id=\"submit\" class=\"btn btn-lg btn-primary btn-block\" type=\"submit\">Sign In</button>");  
            if (session.getAttribute("errorMessage") != null) out.println("<div class=\"alert alert-danger mr-auto\" role=\"alert\" style=\"text-align: center; margin-top: 10px\">"+session.getAttribute("errorMessage")+"</div>");
            out.println("               </form>");
            out.println("           </div>");
            out.println("       </div>");
            out.println("       <footer class=\"text-muted dark-footer fixed-footer\">");
            out.println("           <div class=\"container\">");
            out.println("               <p class=\"float-right\">");
            out.println("                   <a href=\"#\">Back to top</a>");
            out.println("               </p>");
            out.println("               <p>High School Management System &copy; 2019</p>");
            out.println("               <p>Please email the <a href=\"mailto:administrator@hsms.edu.au\">Administrator</a> for help.</p>");
            out.println("           </div>");
            out.println("       </footer>");
            out.println("   </body>");
            out.println("</html>");
        }
        
    }
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d49f54f062c44e4256c0dbc4f2f8e38f19fd269
    protected void authenticateLogin() throws ServletException, IOException {
        String redirect = (String)session.getAttribute("redirect");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User loginUser = null;
        ArrayList<String> failedLogins;
        Boolean authenticated = false;
        //sukonrat
        AuditLogDAO auditLogDao = (AuditLogDAO)session.getAttribute("auditLogDao");        
        String firstName = request.getParameter("firstName");
        Date loginTime = new Date();
        //String loginTime = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new java.util.Date());

        //Does email exist?
        if (controller.getUsers(null, null, null, null, null, email, null, null, 0, true, "firstname", 1).length != 0) {
            loginUser = controller.getUsers(null, null, null, null, null, email, null, null, 0, true, "firstname", 1)[0];
<<<<<<< HEAD
=======
        protected void loginAuth(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession();
            EmailNotifier emailNotification = new EmailNotifier();
            String redirect = (String)session.getAttribute("redirect");
            UserDao userDao = (UserDao)session.getAttribute("userDao");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            User loginUser = null;
            ArrayList<String> failedLogins;
            if (userDao.getUsers(null, null, null, null, null, email, null, null, 0, "firstname", 1) != null)
                loginUser = userDao.getUsers(null, null, null, null, null, email, null, null, 0, "firstname", 1)[0];
            Boolean authenticated = false;
            AuditLogDAO auditLogDao = (AuditLogDAO)session.getAttribute("auditLogDao");
            Date loginTime = new Date();
>>>>>>> 1ef0914b71f918c58fd3a42470c579c0f38c4beb
=======
>>>>>>> 4d49f54f062c44e4256c0dbc4f2f8e38f19fd269
            try {  
                if (loginUser != null) if (PasswordEncrypt.validatePassword(password, loginUser.getPassword())) authenticated = true;
            }//Keep authenticated = false
            catch (NoSuchAlgorithmException | InvalidKeySpecException | NumberFormatException ex) { authenticated = false; }
<<<<<<< HEAD
<<<<<<< HEAD
=======
            //session.setAttribute("user", new User(new ObjectId("5d58b31df28d4f28c41f0908"), "Backdoor", "Backdoor", "Backdoor", "Backdoor", "Backdoor", 1));
            //Authentication Passed
            if (authenticated) {//Login success
                session.setAttribute("user", loginUser);
                session.removeAttribute("errorMessage");
                auditLogDao.addLoginTime(loginUser.getFirstName(),loginTime);
            }
            //Redirect to any page on the website depending on where the log in request came from
            if (redirect == null || redirect.equals("null")) response.sendRedirect("index.jsp");   
            else response.sendRedirect(redirect + ".jsp");
>>>>>>> 1ef0914b71f918c58fd3a42470c579c0f38c4beb
=======
>>>>>>> 4d49f54f062c44e4256c0dbc4f2f8e38f19fd269
        }
        //session.setAttribute("user", new User(new ObjectId("5d58b31df28d4f28c41f0908"), "Backdoor", "Backdoor", "Backdoor", "Backdoor", "Backdoor", 1));
        //Authentication Passed
        if (authenticated) {//Login success
            session.setAttribute("user", loginUser);
            session.removeAttribute("errorMessage");
            session.removeAttribute("failedLogins");
            auditLogDao.addLoginTime(loginUser.getFirstName(),loginTime);
        }//Authentication Failed
        else {//If attribute failedLogins exists, get the attribute, otherwise initialize a new one
            session.setAttribute("errorMessage", "Username or Password Incorrect");
            if (session.getAttribute("failedLogins") != null) failedLogins = (ArrayList<String>)session.getAttribute("failedLogins");
            else failedLogins = new ArrayList<String>();
            if (loginUser != null) {//If email exists in database, add it to failed logins count (logging up to 5 counts)
                failedLogins.add(email); //Add the failed email to the ArrayList for processing
                try {
                    if (controller.checkFailedLogins(email, failedLogins)) {// Email found > 5 times in ArrayList
                        String recipient = "uts.asd.hsms@gmail.com", subject = "Suspicous Activity detected on HSMS", 
                                body = "Dear " + loginUser.getFirstName() + ",\n\nYour email has had over 5 failed log in attempts.\n"
                                + "If this was not you, please log into your account to change your password here: https://uts-asd-hsms.herokuapp.com/userprofile.jsp. \n"
                                + "Or contact a HSMS Administrator immediately for assistance: administrator@hsms.edu.au.\n\n"
                                + "Kind Regards,\n"
                                + "The HSMS Team";
                        session.setAttribute("errorMessage", String.format("%s has had over 5 failed log in attempts. An Administrator has been notified.", email));
                        controller.sendEmail(recipient, subject, body);
                    }
                    session.setAttribute("failedLogins", failedLogins);//Add new ArrayList fo the session to keep count of failed logins
                }//If smtp.gmail.com email server fails to send the email
                catch (MessagingException ex) {session.setAttribute("errorMessage", ex.getMessage());}
            }
            //sukonrat            
            auditLogDao.addLoginTime(firstName, loginTime);
        }
        //Redirect to any page on the website depending on where the log in request came from
        if (redirect == null || redirect.equals("null")) response.sendRedirect("index.jsp");   
        else response.sendRedirect(redirect + ".jsp");
    }
}
