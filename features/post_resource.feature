Feature: Add resources to the website

As a resource provider or an administrator
So that I can share the information of the current available resource to the resource consumers
I want to add the information of available resources to the website

Scenario: Post an resouece to empty websie
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given I am on the create resource page
  Then I fill in "resource_name" with "sample_resource"
  Then I press "Submit"
  Then I should see "sample_resource"

Scenario: Post an resouece to the websie contain other resourses
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given I am on the create resource page
  Then I fill in "resource_name" with "sample_resource1"
  Then I press "Submit"
  Then I follow "New Resource"
  Then I fill in "resource_name" with "sample_resource2"
  Then I press "Submit"
  Then I should see "sample_resource1"
  And I should see "sample_resource2"

Scenario: Post an resouece without an resource_name (sad path)
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given I am on the create resource page
  Then I press "Submit"
  Then I should see "Name can't be blank"


Scenario: Post a resource as a consumer (sad path)
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up 
  Given I am on the home page 
  When I follow "New Resource"
  Then I should see "Please register as a provider to create resource!"


Scenario: Post a resouce without signing in 
  Given I am on the home page 
  When I follow "New Resource"
  Then I should be on the login page