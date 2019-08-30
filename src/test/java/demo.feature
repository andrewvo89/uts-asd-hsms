#----------------------------------
# Empty Cucumber .feature file
#----------------------------------

@RunWith
Feature: Website is deployed Properly

# A very simple scenario
   Scenario: Website is deployed Properly      
    Given I have opened the browser
    When I visit website
    Then website returns content
