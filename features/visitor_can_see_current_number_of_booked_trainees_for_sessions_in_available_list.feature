@javascript
Feature: Visitor can see current number of booked trainees

    As a visitor,
    In order to see how booked an available session is,
    I would like to be able to see how many people are booked on a given session in the list view.

	Background:
		Given the following users exists
			| first_name | last_name | email          | password | role    |
			| John       | Doe       | john@mail.com  | password | trainee |
			| John2      | Doe       | john2@mail.com | password | trainee |
			| John3      | Doe       | john3@mail.com | password | trainee |
			| John4      | Doe       | john4@mail.com | password | trainee |

		And the following price table exists
			| price_point | trainee_1 | trainee_3 | trainee_4 | trainee_5 | trainee_6 | trainee_7 | trainee_8 |
			| low         | 60        | 25        | 20        | 15        | 10        | 8         | 5         |

		And the following sessions exist
			| title    | start_date          | end_date            | status    | price_table_id |
			| Bodypump | 2019-02-01 15:00:00 | 2019-02-01 15:30:00 | scheduled | 1              |

        And multiple trainees buy a session

    Scenario: Trainee can view number of trainees in session on the Home Page
        Given I visit the site
		And I should see 'BODYPUMP'
		And I should see 'Jane1'
		And I should see '01/02/2019, 15:00:00'
		And I should see '4'
