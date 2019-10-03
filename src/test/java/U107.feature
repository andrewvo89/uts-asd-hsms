@RunWith
Feature: U107
   As a principal
   I want remove a job role once it has been fulfilled
   In order for teachers to not apply for a job position that has already been filled

   Background: Delete an existing job role    
      Given the job has been fulfilled

   Scenario Outline: Start deleting a job role
      When U107 I click on delete job
      And U107 I confirm delete
      Then U107 I should get a message indicating <result>
      Examples:
         |result     |
         |"success"  |