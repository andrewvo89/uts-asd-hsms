@RunWith
Feature: U106
   As a principal
   I want edit an existing job role on the HSMS
   In order for the details to be correct and accurate

   Background: Edit existing job role    
      Given I am on the job management page

   Scenario Outline: Start editing a job role
      When U106 I click on edit job
      And U106 I change title to <title> and close date to <date>
      Then U106 I should get a job edit message indicating <result>
      Examples:
         |title                                                 |date       |result     |
#          |""                                                    |"00000000" |"danger"   |
#          |"_art head teacher"                                   |"06112019" |"success"  |
#          |"123456789012345678901234567890123456789012345678901" |"25122019" |"danger"   |
#          |"Junior Art Teacher"                                  |"25122018" |"danger"   |
         |"Senior Science Teacher"                                     |"25122019" |"success"  |