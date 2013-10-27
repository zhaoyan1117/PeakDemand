Feature: post the potential demand on the app
 
As a resource consumer
So that I can let the resource providers and other resource consumers know my potential demands for the resource
I want to post my potential demand of a given resource on the app

Scenario: Post a demand to an existing resource as a consumer

  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given the following resources posted by "p1@p1.com":
  | name | start_at | end_at   |
  | R1   |2013-10-26|2014-12-26|
  When I follow "Log out"
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up

  When I am on the create resource page for "R1"
  When I choose "demand_intensity_moderate"
  Then I press "Submit"
  Then I should see "Demand on R1"
  When I follow "Go Back"
  Then I should see "c1"
  And I should see "MODERATE"

Scenario: Post a demand as a provider (sad path)
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up 
  Given the following resources posted by "p1@p1.com":
  | name | start_at |  end_at   |
  | R1   |2013-10-26|2013-11-18 |
  When I am on the resource detail page of "R1"
  When I follow "Create Demand"
  Then I should see "Please register as a consumer to create demand!"

Scenario: Post a demand without signing in 
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up 
  Given the following resources posted by "p1@p1.com":
  | name | start_at |  end_at   |
  | R1   |2013-10-26|2013-11-18 |
  When I follow "Log out"
  When I am on the resource detail page of "R1"
  When I follow "Create Demand"
  Then I should be on the login page 