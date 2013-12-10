Feature: add resource calendar to private calendar list

As a user
So that I can access the resource calendar I cared more easily
I want to add resource calendar to my private calendar list

Scenario: Click to copy the calendar id for a resource by a guest user
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  When I follow "Log Out"
  When I am on the resource detail page of "R1"
  Then I should see "Demand Calendar"

Scenario: Click to copy the calendar id for a resource by a provider
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  When I am on the resource detail page of "R1"
  Then I should see "Demand Calendar"

Scenario: Click to copy the calendar id for a resource by a consumer
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  When I follow "Log Out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up 
  When I am on the resource detail page of "R1"
  Then I should see "Demand Calendar"
