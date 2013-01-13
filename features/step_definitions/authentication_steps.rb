Given /^a user visits the signin page$/ do
	visit zaloguj_path
end

When /^he submits invalid signin information$/ do
	click_button "Logowanie"
end

Then /^he should see an error message$/ do
	page.should have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
	@user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid signin information$/ do
	fill_in "session_email", with: @user.email
	fill_in "session_password", with: @user.password
	click_button "Logowanie"
end

Then /^he should see his profile page$/ do
	page.should have_selector('title', text: @user.name)
end

Then /^he should see a signout link$/ do
	page.should have_link('Wylogowanie', href: wyloguj_path)
end
