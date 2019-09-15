@RunWith
Feature: U122
   As a teacher
   I want to submit class rolls
   In order to update student attendance

   Background: Edit current attendance      
      Given I am on the class roll management page

   Scenario Outline: Start editing a class roll
      When I click on edit on attendance
      And I change wk1 to <wk1>
      Then I should get a message indicating <result>
      Examples:
         |wk1        |result     |
         |"P"        |"success"  |
         |"L"        |"success"  |
         |"A"        |"success"  |
         |"away"     |"danger"   |
         |"s"        |"danger"   |

   
