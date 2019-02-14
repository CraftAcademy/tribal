Given("I visit the site") do
	visit root_path
end

When("I fill in {string} with {string}") do |element, value|
	fill_in element, with: value
end

When("I click {string}") do |element|
	click_on element
end

Given("I am logged in as {string}") do |email|
	@user = User.find_by email: email
	login_as @user, scope: :user
	visit root_path
end

Given("I fill in {string} field with {string}") do |element, value|
	fill_in element, with: value
end

When("I select {string} from {string}") do |option, selection|
  select option, from: selection
end

Given("I set the date and time") do
    fill_in 'session[start_date]', with: Time.new()
end

Given('I fill in the payment form') do
  card_no = '42'
  stripe_iframe = find("iframe[name='__privateStripeFrame4']", visible: false)
  within_frame stripe_iframe do
    card_field = find_field('cardnumber')
    card_field.native.clear
    8.times { sleep 0.1; card_field.send_keys(right: card_no); sleep 0.1; }

    find_field('exp-date').send_keys('1221')
    find_field('cvc').send_keys('123')
  end
end

Then("I wait 2 seconds") do
  sleep 2
end

Given("the time is {int} {int} {int} {int}:{int}:{int}") do |int, int2, int3, int4, int5, int6|
	new_time = Time.local(int, int2, int3, int4, int5, int6)
	Timecop.freeze(new_time)
end

Given("the job runs") do
	Delayed::Worker.new.run(Delayed::Job.last)
end

Then("the amount is {int}") do |amount|
	user = User.find_by(first_name: 'John')
	transaction = Transaction.find_by(user_id: user.id)
	expect(transaction.amount).to equal amount
end

Then("three more trainees attend") do
	session = Session.find_by(title: 'Crossfit')
	session.users << User.find_by(first_name: 'John2')
	session.users << User.find_by(first_name: 'John3')
	session.users << User.find_by(first_name: 'John4')
end


Given("coach Jack has created the session") do
	session = Session.find_by(title: 'Crossfit')
  session.users << User.find_by(first_name: 'Jack')
end

Given("I click {string} within {string}") do |button, dom|
	within("div##{dom}") do
		click_on button
  end
end

Given("trainee Jon buys a session") do
	session = Session.find_by(title: 'Crossfit')
  session.users << User.find_by(first_name: 'Jon')
end

Given("multiple trainees buy a session") do
	session = Session.find_by(title: 'Bodypump')
	session.users << User.find_by(first_name: 'John')
	session.users << User.find_by(first_name: 'John2')
	session.users << User.find_by(first_name: 'John3')
	session.users << User.find_by(first_name: 'John4')
end

Then("show me the page") do
	save_and_open_page
end

Then("binding.pry") do
	binding.pry
end
