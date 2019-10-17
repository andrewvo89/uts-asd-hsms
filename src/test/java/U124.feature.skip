@Runwith
Feature: U124
    As a staff member
    I want to submit feedback
    In order for important issues to be raised

Background: Submit new feedback
    Given I am on the complaint fill page

Scenario Outline: Start filling complaint form
    When U124 I change the comment subject to <commSubject>
    And U124 I write my comment as <comment>
    Then U124 I should get a message indicating <result>
    Examples:
    |commSubject        |comment                        |result     |
    |"Harassment"       |"I am being cat called."       |"success"  |
    |"Other"            |"Can we get yellow paint for kids with poor vision?" |"success"   |
    |"Discrimination"   |"Here at High School Management High School, we are dedicated to ensuring the happiness of both our students and our staff. For this reason, we are always looking for ways to improve all aspects of the school. If you have any issues, feedback, information, or thoughts that you feel can help better, please leave a comment below, and Susan in the admin office will escalate the comment appropriately. Remember, all your information is private. This is an anonymous feedback service, and the author of any comments cannot be traced." |"danger" |

   
