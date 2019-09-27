@RunWith
Feature: U105
   As a teacher
   I want to apply for a job role on HSMS
   In order fruther my teaching career

   Background: Apply for a job
      Given I am on the job board page

   Scenario Outline: Start applying for a job
      When U105 I click on apply
      And U105 I write my cover letter as <coverletter>
      Then U105 I should get a message indicating <result>
      Examples:
         |coverletter          |result     |
         |""                   |"danger"   |
         |"Hi Science Department,\nI am highly interested in this role and am ready to start immediately.\nPlease consider me for this role\n\nKind Regards, Sally."|"success"   |