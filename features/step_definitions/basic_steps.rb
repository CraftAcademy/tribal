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

Given("show me the page") do
	save_and_open_page
end

When("I select {string} from {string}") do |option, selection|
  select option, from: selection
end

Given("I set the date and time") do
    fill_in 'session[startDate]', with: Time.new()
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
	Delayed::Worker.new.run( Delayed::Job.find(1))
end
