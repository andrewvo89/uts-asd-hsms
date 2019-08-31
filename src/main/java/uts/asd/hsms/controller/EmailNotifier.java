/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Andrew
 */
public class EmailNotifier {
    
    private Session session;
    private Properties properties;
    private MimeMessage message;
    private Transport transport;
    
    
    public void sendEmail(String recipient, String subject, String body) throws AddressException, MessagingException {
        String host = "smtp.gmail.com", from = "uts.asd.hsms@gmail.com", pass = "Password!1", port = "465";   
        
        properties = new Properties();
        properties.put("mail.smtp.user", from);
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.ssl.trust", host);
        properties.put("mail.smtp.password", pass);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");


        // Get the default Session object.
        session = Session.getInstance(properties);
       
        message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        message.setSubject(subject);
        message.setText(body);

        // Send message
        transport = session.getTransport("smtp");
        transport.connect(host, from, pass);
        transport.sendMessage(message, message.getAllRecipients());
        transport.close();
    }
}
