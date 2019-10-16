/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller.validator;

import java.util.Set;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import uts.asd.hsms.model.Calendar;

/**
 *
 * @author MatthewHellmich
 */
public class CalendarValidator {

    private Calendar calendar;

    public CalendarValidator(Calendar calendar) {
        this.calendar = calendar;
    }

    public Calendar getCalendar() {
        return calendar;
    }

    public void setCalendar(Calendar calendar) {
        this.calendar = calendar;
    }

    public String[] validateCalendar() {
        String[] messages;
        //Create ValidatorFactory which returns validator
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();

        //It validates bean instances
        Validator validator = factory.getValidator();

        //Validate bean
        Set<ConstraintViolation<Calendar>> constraintViolations = validator.validate(calendar, ValidatorSequence.class);

        if (constraintViolations.size() > 0) {
            messages = new String[constraintViolations.size()];
            int count = 0;
            for (ConstraintViolation<Calendar> violation : constraintViolations) {
                messages[count] = violation.getMessage();
                count++;
            }
            return messages;
        }
        return null;
    }
}
