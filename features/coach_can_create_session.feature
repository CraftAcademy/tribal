Feature: Coach can create session

    As a coach
    In order to utilize my spare time
    I would like to be able to make sessions on Tribal

    Background:
        Given the following price table exists
            | price_point | trainees |
            | low         | 4        |

        And the following user exists
            | email           | password | password_confirmation | first_name | last_name |
            | coach@email.com | password | password              | Coach-Jon  | Doe       |
        And I visit the site
        And show me the page
        And I click 'Add Session'
        

    Scenario: Coach can create session
        Given I fill in 'Title' field with 'Spinning'
        And I fill in 'start_date' field with '2019-02-20 20:00'
        And I select 'low' from 'price_table_id'
        And I click 'Create Session'
        And I should see 'Spinning'
        Then I should see 'Session successfully created'
    
    Scenario: Coach can not create session
        Given I click 'Create Session'
        Then I should see 'Every field needs to be filled in!'