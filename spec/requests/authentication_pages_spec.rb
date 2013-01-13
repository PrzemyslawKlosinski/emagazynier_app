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

describe "strona logowania" do
	before { visit zaloguj_path }

	it { should have_selector('title', text: "Logowanie")}
	it { should have_content("Logowanie") }

	#gdy logowanie nieudane
	describe "with invalid information" do
		before { click_button "Logowanie" }

		it { should have_selector('title', text: 'Logowanie') }
		it { should have_selector('div.alert.alert-error', text: 'Nie udane') }

		describe "after visiting another page" do
			before { click_link "Pomoc" }
			it { should_not have_selector('div.alert.alert-error') }
		end
	end

	#gdy logowanie udane
	describe "with valid information" do
		#uzywamy factory Girl dla modelu user
		let(:user) { FactoryGirl.create(:user) }

		before do
			fill_in "session_email", with: user.email
			fill_in "session_password", with: user.password
			click_button "Logowanie"
		end

		it { should have_selector('title', text: user.name) }
		it { should have_link('Stan magazynowy', href: user_path(user)) }
		it { should have_link('Wylogowanie', href: wyloguj_path) }
		it { should_not have_link('Zaloguj', href: zaloguj_path) }

		describe "followed by signout" do
			before { click_link "Wylogowanie" }
			it { should have_link('Logowanie') }
		end

	end
end

end
