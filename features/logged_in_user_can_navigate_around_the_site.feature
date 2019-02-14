@javascript

Feature: Logged in User can Navigate around the site

    As a logged in user,
    In order to effectively move to specific areas of the site,
    I would like to select pages/views from a navigation bar.

	Background:

		Given the following users exists
			| email             | password | password_confirmation | first_name | last_name | role    |
			| coach@email.com   | password | password              | Jack       | Doe       | coach   |
			| trainee@email.com | password | password              | Jon        | Doe       | trainee |

		And the following sessions exist
			| title    | start_date          | end_date            | status    |
			| Crossfit | 2019-02-01 15:00:00 | 2019-02-01 15:30:00 | confirmed |

		And coach Jack has created the session
		And trainee Jon buys a session
		And I am logged in as 'trainee@email.com'

	Scenario: Logged in User can return to landing page from Session Page
		Given I click 'Join' within 'confirmed'
		And I click 'Join Session'
		And I click 'Home'
		And I should see 'Available Sessions'