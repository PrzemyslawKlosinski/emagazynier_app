require 'spec_helper'

describe "AuthenticationPages" do

#   describe "GET /authentication_pages" do
#     it "works! (now write some real specs)" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       get authentication_pages_index_path
#       response.status.should be(200)
#     end
#   end

subject { page }

describe "Authentykacja - strona logowania" do
	before { visit zaloguj_path }

	it { should have_selector('title', text: "Logowanie")}
	it { should have_content("Logowanie") }

	#gdy logowanie nieudane
	describe "with invalid information" do
		before { click_button "Logowanie" }

		it { should have_selector('title', text: 'Logowanie') }
		# it { should have_selector('div.alert.alert-error', text: 'Nie udane') }
		# WYKORZYSTUJEMY metode zdefiniowana w spec/support/utilities.rb
		it { should have_error_message('Nie udane') }
		it { should_not have_selector('a href', text: 'Dane podstawowe') }

		describe "after visiting another page" do
			before { click_link "Pomoc" }
			it { should_not have_selector('div.alert.alert-error') }
		end
	end

	#gdy logowanie udane
	describe "with valid information" do
		#uzywamy factory Girl dla modelu user
		let(:user) { FactoryGirl.create(:user) }

		# before do
		# 	fill_in "session_email", with: user.email
		# 	fill_in "session_password", with: user.password
		# 	click_button "Logowanie"
		# end
		# WYKORZYSTUJEMY metode zdefiniowana w spec/support/utilities.rb
		before { valid_signin(user) }

		it { should have_selector('title', text: user.name) }
		it { should have_link('Stan magazynowy', href: user_path(user)) }
		it { should have_link('Dane podstawowe', href: edit_user_path(user)) }
		it { should have_link('Wylogowanie', href: wyloguj_path) }
		it { should_not have_link('Zaloguj', href: zaloguj_path) }

		describe "followed by signout" do
			before { click_link "Wylogowanie" }
			it { should have_link('Logowanie') }
		end

	end
end

#Autoryzacja
describe "as wrong user" do
	let(:user) { FactoryGirl.create(:user) }
	let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }

	before do

      ###Authorization
      visit zaloguj_path(user)
      valid_signin(user)

	end

	describe "visiting Users#edit page" do
		before { visit edit_user_path(wrong_user) }
		it { should_not have_selector('title', text: caly_tytul('Dane podstawowe')) }
	end

	describe "submitting a PUT request to the Users#update action" do
		before { put user_path(wrong_user) }
		specify { response.should redirect_to(user) }
	end
end

end
