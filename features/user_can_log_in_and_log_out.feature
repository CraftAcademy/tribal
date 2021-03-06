@javascript
Feature: User can log in and out
	As a Visitor
	In order to use the site functionality
	I want sign up and log in

	Background:
		Given the following users exists
			| email          | password | password_confirmation | first_name | last_name | role    |
			| real@email.com | password | password              | Jon        | Doe       | trainee |
		And I visit the site
		And I click 'Login'

	Scenario: If user fills in the login form correctly he can log in
		When I fill in 'email' with 'real@email.com'
		And I fill in 'password' with 'password'
		And I click 'Log in'
		Then I should see 'Hello, Jon!'

	Scenario: If user doesn't fill in the form he will see an error message
		When I click 'Log in'
		Then I should see 'Invalid Email or password.'

	Scenario: If user fills in only email he will see an error message
		When I fill in 'email' with 'rel@email.com'
		And I click 'Log in'
		Then I should see 'Invalid Email or password.'

	Scenario: If user fills in the only password he will see an error message
		When I fill in 'password' with 'password'
		And I click 'Log in'
		Then I should see 'Invalid Email or password.'

	Scenario: If user fills in the login form incorrectly he will see an error message
		When I fill in 'email' with 'rel@email.com'
		And I fill in 'password' with 'passwo'
		And I click 'Log in'
		Then I should see 'Invalid Email or password.'

	Scenario: User can log out when logged in
		Given I am logged in as "real@email.com"
		When I click 'Logout'
		Then I should not see 'Hello, Jon!'
