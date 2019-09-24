/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class LoginDeniedServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            out.println("   <header>");
            out.println("       <nav class=\"navbar navbar-expand-md navbar-dark fixed-top bg-dark\">");
            out.println("           <div class=\"container\">");
            out.println("               <a class=\"navbar-brand\" href=\"index.jsp\"><strong style=\"font-size: 30px\">High School</strong><span style=\"font-size: 30px; font-weight: 300; color: rgba(255,255,255,0.7);\">Management System</span></a>");
            out.println("           </div>");
            out.println("       </nav>");
            out.println("   </header>");
            out.println("       <div class=\"main\" role=\"main\">");
            out.println("           <div class=\"container\">");
            out.println("               <h2>Access Denied</h2>");
            out.println("               <p>Redirecting to Home in 3 seconds</p>");
            out.println("               <script>");
            out.println("               var timer = setTimeout(function() {");
            out.println("                   window.location='index.jsp'");
            out.println("               }, 3000);");
            out.println("               </script>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
