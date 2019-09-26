/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.JobApplication;
import uts.asd.hsms.model.dao.JobApplicationDao;
import uts.asd.hsms.model.dao.JobDao;


/**
 *
 * @author ALVIN
 */
public class NewsFeedController {
        private JobApplicationDao jobApplicationDao;
    private JobDao jobDao;
    private SimpleDateFormat longDate = new SimpleDateFormat("d MMMM"); 
}
         //Pre-fill department bnh radio buttons