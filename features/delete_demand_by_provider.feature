Feature: resource provider can delete demands on its own resource

As a resource provider
So that I can manage the resource I post
I want to be able to delete the demands posted under my resource

Scenario: Delete demand by a provider
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  When I follow "Log Out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up
  When I am on the create demand page for "R1"
  When I choose "demand_intensity_moderate" with in "#new_demand_modal form"
  Then I press "Submit" to create demand with in "#new_demand_modal form"
  When I am on the create demand page for "R1"
  Then I push the selector "#demand_1"
  Then I push the selector ".btn_delete_demand"
  And I should not see "D1"
