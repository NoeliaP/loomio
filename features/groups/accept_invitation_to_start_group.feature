Feature: Group admin accepts invitation to start a Loomio group
  As a future Loomio group admin
  So that I can make decisions with my group on Loomio
  I want to be able to accept an invitation to Loomio

  Scenario: Group admin accepts invitation to start a Loomio group
    Given I have requested to start a loomio group and the request has been approved
    When I open the email and click the invitation link
    And I log in
    Then I should become the admin of the group
    And the group request should be marked as accepted

