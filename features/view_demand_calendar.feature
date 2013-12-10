Feature: check demands by clicking calendar

As a site user
So that I can check demands more conveniently
I would like to click on the calendar entry to view the corresponding demand information.

Scenario: View the number of demands on the detail page of resource
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  Then I follow "Log Out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up
  When I am on the create demand page for "R1"
  When I choose "demand_intensity_moderate" with in "#new_demand_modal form"
  Then I press "Submit" to create demand with in "#new_demand_modal form"
  When I go to the resource detail page of "R1"
  Then I should see "c1"
  And I should see "MODERATE"