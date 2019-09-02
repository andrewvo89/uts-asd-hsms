@RunWith
Feature: U102
   As a principal
   I want edit an existing teacher
   In order to update their details

   Background: Edit existing user      
      Given I am on the user management page

   Scenario Outline: Start editing a user
      When I click on edit
      And I change phone to <phone> and email to <email>
      Then I should get a message indicating <result>
      Examples:
         |phone               |email                    |result     |
         |"1234567890"        |"aaron1@hsms.edu.au"     |"success"  |
         |"203abc"            |"aaron@gmail.com"        |"danger"   |
         |"046458764"         |"principal@hsms.edu.au"  |"success"  |
         |"+614885646"        |"aaronchen@hsms.edu.au"  |"danger"   |
         |"0297247764"        |"aaron@hsms.edu.au"      |"success"  |