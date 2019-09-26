@RunWith
Feature: U104
   As a principal
   I want to post an internal job position onto the HSMS
   In order for internal teachers to apply for job roles

   Background: Edit existing job role    
      Given I am on the job management page

   Scenario Outline: Post a job role onto the job board
      When U104 I click on add job
      And U104 I change the title to <title> description to <description> and close date to <date>
      Then U104 I should get a message indicating <result>
      Examples:
         |title            |description     |date       |result     |
#          |""               |"A science teacher is required immediately to start right away."|"30112020" |"danger"   |
#          |"Science Teacher"|""|"30112020" |"danger"   |
#          |"Science Teacher"|"A science teacher is required immediately to start right away."|"30122018" |"danger"  |
         |"Senior Science Teacher"|"A senior science teacher is required immediately to start right away."|"30112020" |"success"   |