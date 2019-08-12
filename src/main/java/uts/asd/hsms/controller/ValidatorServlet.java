package uts.asd.hsms.controller;

import uts.asd.hsms.model.User;
import uts.asd.hsms.model.dao.MongoDBConnector;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author George
 */
public class ValidatorServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Validator validator = new Validator();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = null;
        
        String adminemail = (String)session.getAttribute("adminemail");
        String adminpass = (String)session.getAttribute("adminpassword");
        MongoDBConnector connector = new MongoDBConnector(adminemail, adminpass);

        if (!validator.validateEmail(email)) {
            session.setAttribute("emailErr", "Incorrect email format");            
            request.getRequestDispatcher("index.jsp").include(request, response);
        } else if (!validator.validatePassword(password)) {
            session.setAttribute("passErr", "Incorrect password format");
            request.getRequestDispatcher("index.jsp").include(request, response);
        } else {
            try {
                user = connector.user(email, password);
                session.setAttribute("user", user);
                request.getRequestDispatcher("main.jsp").include(request, response);
            } catch (NullPointerException ex) {
                session.setAttribute("existErr", "User does not exist!");
                request.getRequestDispatcher("main.jsp").include(request, response);
            }
        }
    }
}
