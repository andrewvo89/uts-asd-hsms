/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.controller.validator;

import javax.validation.GroupSequence;
import javax.validation.groups.Default;

/**
 *
 * @author Andrew
 */
@GroupSequence({Default.class, ValidatorGroupA.class, ValidatorGroupB.class, ValidatorGroupC.class, ValidatorGroupD.class, 
    ValidatorGroupE.class, ValidatorGroupF.class, ValidatorGroupG.class})
public interface UserValidatorSequence {
}