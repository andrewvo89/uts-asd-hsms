#----------------------------------
# Empty Cucumber .feature file
#----------------------------------

@RunWith
Feature: Test open HSMS Website

# A very simple scenario
   Scenario: Test login button enabled   
    Given I have opened the browser
    When Website is loaded
    Then Login button should exist
