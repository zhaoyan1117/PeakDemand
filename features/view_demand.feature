Feature: view the potential demand status on the app

As a resource provider or an administrator
So that I can plan ahead to avoid peak demand for the resources in the future
I want to know the potential demand situation of the resource

Scenario: View the number of demands from the resource index page
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  Then I follow "Log Out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up
  When I am on the create demand page for "R1"
  When I choose "demand_intensity_moderate"
  Then I press "Submit" to create demand
  When I go to the home page
  Then I should see "R1"
  Then I should see "1"

Scenario: View the number of demands on the detail page of resource
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  Then I follow "Log Out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up
  When I am on the create demand page for "R1"
  When I choose "demand_intensity_moderate"
  Then I press "Submit" to create demand
  When I go to the resource detail page of "R1"
  Then I should see "c1"
  And I should see "MODERATE"

Scenario: View demand detail on the detail page of resource
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  When I follow "Log Out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up
  When I am on the create demand page for "R1"
  When I choose "demand_intensity_moderate"
  Then I press "Submit" to create demand
  When I am on the resource detail page of "R1"
  #Then inspect
  When I push the selector "#demand_1"
  Then I should see "MODERATE"


