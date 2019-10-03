/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import java.util.Date;
import javax.servlet.http.HttpSession;
import org.bson.types.ObjectId;
import uts.asd.hsms.model.Job;
import uts.asd.hsms.model.dao.JobDao;

/**
 *
 * @author Andrew
 */
public class IndexController {
    private JobDao jobDao;
    
    public IndexController(HttpSession session) {
        jobDao = (JobDao)session.getAttribute("jobDao");
    }
    
    public Job[] getJobs(ObjectId jobId, String title, String description, String workType, String department, String status, Date postDate, Date closeDate, Boolean active, String sort, int order) {
        return jobDao.getJobs(jobId, title, description, workType, department, status, postDate, closeDate, active, sort, order);
    }
}
