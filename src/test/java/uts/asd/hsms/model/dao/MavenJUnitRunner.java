/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.asd.hsms.model.dao;

import org.junit.runner.JUnitCore;

/**
 *
 * @author ADMIN
 */
public class MavenJUnitRunner {
    public static void main(String[] args) {
        System.out.println("- Testing MavenJUnitTest: ");
        org.junit.runner.Result result = JUnitCore.runClasses(MavenJUnitTest.class);
        result.getFailures().forEach((failure) -> {
            System.out.println(failure.toString());
        });
        String status = result.wasSuccessful() ? "Passed" : "Failed";
        System.out.println(status + " Test status = ");
        System.out.println(" Number of Tests Passed = " + result.getRunCount());
        System.out.println(" Number of Tests Ignored = " + result.getIgnoreCount());
        System.out.println(" Number of Tests Failed = " + result.getFailureCount());
        System.out.println(" Time = " + result.getRunTime() / 1000.0 + "s");
    }
}
