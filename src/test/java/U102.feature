#----------------------------------
# Empty Cucumber .feature file
#----------------------------------

@RunWith
Feature: U102
As a principal
I want edit an existing teacher
In order to update their details

# A very simple scenario
    Background: Edit existing user      
    Given I am on the user management page
   
   Scenario Outline: Start editing a user
    When I click on edit
    And change email to <email>
    Then I should get a message indicating <result>
Examples:
|email                                  |result     |
|"administrator@hotmail.com"            |"danger"   |
|"aaron@gmail.com"                      |"danger"   |
|"principal@hsms.edu.au"                |"success"  |
|"aaronchen@teacher.hsms.edu.au"        |"danger"   |
|"aaron@hsms.edu.au"                    |"success"  |