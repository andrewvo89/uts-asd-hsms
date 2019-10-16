/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model;

import java.io.Serializable;
import java.util.Date;
import javax.validation.constraints.Pattern;
import org.bson.types.ObjectId;
import uts.asd.hsms.controller.validator.*;

/**
 *
 * @author MatthewHellmich
 */
public class Calendar implements Serializable {

    private ObjectId calendarId;
    private Date date;
    @Pattern(regexp = "^[A-Za-z 0-9]{1,32}$", message = "<h5 class=\"alert-heading\">Event Name Error</h5><hr>"
            + "Cannot be blank<br>"
            + "No more than 32 Characters<br>"
            + "No Special Characters - Letters and Numbers Only<hr>", groups = ValidatorGroupA.class)
    private String eventName;
    @Pattern(regexp = "^$|.{1,32}$", message = "<h5 class=\"alert-heading\">Description Error</h5><hr>"
            + "No more than 32 Characters<br>", groups = ValidatorGroupB.class)
    private String description;
    private String eventTag;

    public Calendar(ObjectId calendarId, Date date, String eventName, String description, String eventTag) {
        this.calendarId = calendarId;
        this.date = date;
        this.eventName = eventName;
        this.description = description;
        this.eventTag = eventTag;
    }

    public ObjectId getCalendarId() {
        return calendarId;
    }

    public void setCalendarId(ObjectId calendarId) {
        this.calendarId = calendarId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEventTag() {
        return eventTag;
    }

    public void setEventTag(String eventTag) {
        this.eventTag = eventTag;
    }
}
