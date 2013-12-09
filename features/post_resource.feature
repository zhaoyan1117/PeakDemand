Feature: add the status of some available resource (sets of clusters) on the app

As a resource provider or an administrator
So that I can share the information of the current available resource to the resource consumers
I want to add the information of available resources to the website

Scenario: Post an resouece to empty websie
  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
  Given I am on the home page
  Then I push the selector ".create_resource"
  Then I fill in "resource_name" with "sample_resource"
  Then I press "Submit" to create resource
  Then I should see "sample_resource"

#Scenario: Post an resouece without an resource_name (sad path)
#  Given provider "p1" with email "p1@p1.com" and password "password" has signed up
#  Given I am on the home page
#  Then I push the selector ".create_resource"
#  Then I press "Submit" to create resource
#  Then I should see "Please fill out this feild."


Scenario: Post a resource as a consumer (sad path)
  Given consumer "c1" with email "c1@c1.com" and password "password" has signed up 
  Given I am on the home page 
  Then I should not see "New Resource"

Scenario: Post a resouce without signing in 
  Given I am on the home page 
  Then I should not see "New Resource"