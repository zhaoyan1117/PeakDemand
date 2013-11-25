Feature: contact other resource consumers

As a resource consumer
So that I can negotiate with other consumers to arrange the resource usage
I want to email other consumers

Scenario: Email to consumer after login
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
  When I push the selector "#demand_1"
  Then I should see "To"

Scenario: Email to consumer without login
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  When I follow "Log Out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up
  When I am on the create demand page for "R1"
  When I choose "demand_intensity_moderate"
  Then I press "Submit" to create demand
  When I follow "Log Out"
  When I am on the resource detail page of "R1"
  When I push the selector "#demand_1"
  Then I should see "Login to email the consumer"
