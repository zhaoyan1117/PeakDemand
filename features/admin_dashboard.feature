Feature: administrator to regulate account

As an app administrator
So that I can regulate user registration and sites data
I would like to be able to approve provider registration and delete any resources and demands

Scenario: As an administrator I should see dashboard link on home page
Given administrator "admin" with email "admin@admin.com" and password "password" exist
Given I am on the home page
Then I should see "Dashboard"

Scenario: As an administrator after I followed dashboard link, I should see all users
Given administrator "admin" with email "admin@admin.com" and password "password" exist
Given provider "p1" with email "p1@p1.com" and password "password" has signed up
Given I am on the home page
When I follow "Dashboard"
Then I should see p1
