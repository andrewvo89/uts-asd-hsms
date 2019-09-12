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
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.UserDao;

/**
 *
 * @author Andrew
 */
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doLogin(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loginAuth(request, response);
    }
    
    protected void doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("   <header>");
            out.println("       <nav class=\"navbar navbar-expand-md navbar-dark fixed-top bg-dark\">");
            out.println("           <div class=\"container\">");
            out.println("               <a class=\"navbar-brand\" href=\"index.jsp\"><strong style=\"font-size: 30px\">High School</strong><span style=\"font-size: 30px; font-weight: 300; color: rgba(255,255,255,0.7);\">Management System</span></a>");
            out.println("           </div>");
            out.println("       </nav>");
            out.println("   </header>");
            out.println("   <body>");
            out.println("       <div class=\"main\" role=\"main\">");
            out.println("           <div class=\"container\">");
            out.println("               <form class=\"form-signin\" method=\"post\" action=\"LoginServlet\">");
            out.println("                   <p><img src=\"images/logo.jpg\" alt=\"HSMS Logo\" style=\"width:100%; height:100%;\" class=\"rounded mx-auto d-block\"></p>");
            out.println("                   <label for=\"inputEmail\" class=\"sr-only\">Email address</label>");
            out.println("                   <input name=\"email\"  id=\"email\" type=\"text\" class=\"form-control\" placeholder=\"teacher@hsms.edu.au\" required autofocus>");
            out.println("                   <label for=\"inputPassword\" class=\"sr-only\">Password</label>");
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
            //AuditLogDAO auditLogDao = (AuditLogDAO)session.getAttribute("auditLogDao");
            
            //String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new java.util.Date());
            try {  
                if (loginUser != null) if (PasswordEncrypt.validatePassword(password, loginUser.getPassword())) authenticated = true;
            }//Keep authenticated = false
            catch (NoSuchAlgorithmException | InvalidKeySpecException | NumberFormatException ex) { authenticated = false; }
            //session.setAttribute("user", new User(new ObjectId("5d58b31df28d4f28c41f0908"), "Backdoor", "Backdoor", "Backdoor", "Backdoor", "Backdoor", 1));
            //Authentication Passed
            if (authenticated) {//Login success
                session.setAttribute("user", loginUser);
                session.removeAttribute("errorMessage");
                //auditLogDao.addLoginTime(UserAudit.getUserID, timeStamp);
            }
            //Redirect to any page on the website depending on where the log in request came from
            if (redirect == null || redirect.equals("null")) response.sendRedirect("index.jsp");   
            else response.sendRedirect(redirect + ".jsp");
        }
        
        protected boolean checkFailedLogins(String email, ArrayList<String> failedLogins) {
            int count = 0;
            for(String failedLogin: failedLogins) {
                if (failedLogin.equals(email)) count ++;
            }//If email is found more then 5 times in the ArrayList, return true
            if (count >= 5) return true;
            return false;
        }
        
        

}
