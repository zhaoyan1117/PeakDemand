Feature: display time period set by the customer 
 
As a resource consumer
So that I can let the resource providers and other resource consumers know my potential demands for the resource
I want to post my potential demand of a given resource on the app

Scenario: one consecutive period of time is set (with pre-existing data in the database)
  Given the following time period selected: 
    |  John      | 09/20    |  09/30  |  john@berkeley.edu     |
    |  Peter     | 09/27    |  10/02  |  peter@berkeley.edu    |
    |  Lawrence  | 10/03    |  10/25  |  lawrence@berkeley.edu |
  And  I am on the main page
  When I select "09/01" as start date
  When I select "09/10" as end date
  When I click "submit_time" button
  Then I should see the time period "09/01" to "09/10" is highlighted
  Then I should see the time period "09/20" to "09/30" is highlighted
  Then I should see the time period "09/27" to "10/02" is highlighted
  Then I should see the time period "10/03" to "10/25" is highlighted 
  Then I should not see time periods being highlighted other than: 09/01-09/11,09/20-09/30,09/27-10/02,10/03-10/25

Scenario: submit date with no pre-existing data in the database
  Given I am on the main page
  When I select "09/01" as start date
  When I select "09/10" as end date
  When I click "submit_time" button
  Then I should see the time period "09/01" to "09/10" is highlighted
  Then I should not see time periods being highlighted other than: 09/01-09/10