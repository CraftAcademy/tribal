Then("I should see {string}") do |content|
	expect(page).to have_content content
end

Then("I should see {string} in {string}") do |session, status|
	within("##{status}") do 
		expect(page).to have_content session
	end
end