/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller;

import javax.servlet.http.HttpSession;
import uts.asd.hsms.model.dao.LeaveDao;

/**
 *
 * @author MatthewHellmich
 */
public class LeaveController {
    private LeaveDao leaveDao;
    
    public LeaveController(HttpSession session) {
        leaveDao = (LeaveDao)session.getAttribute("userDao");
    }
}
