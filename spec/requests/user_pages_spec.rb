require 'spec_helper'

describe "UserPages" do
  # describe "GET /user_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get user_pages_index_path
  #     response.status.should be(200)
  #   end
  # end

  subject { page }
  describe "rejestracja page" do
  	before { visit rejestracja_path }

  	it { should have_selector('h3',text: 'Rejestracja') }
  	it { should have_selector('title', text: caly_tytul('Rejestracja')) }
  end

  #testy dla strony profilowej
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h4',text: user.name) }
  end


  #testy rejestracji uzytkownika
  describe "signup" do
    before { visit rejestracja_path }
    let(:submit) { "Zarejestruj konto" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
       end

       describe "after submission" do
        before { click_button submit }
        it { should have_selector('title', text: 'Rejestracja') }
        it { should have_content('znaleziono') }
       end

    end

    describe "with valid information" do
      before do
        fill_in "user_name", with: "Example User"
        fill_in "user_email", with: "test@test.pl"
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('test@test.pl') }
        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Witaj') }
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end
