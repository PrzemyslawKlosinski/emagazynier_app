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
    before { 
      visit zaloguj_path(user)
      valid_signin(user)
      visit user_path(user) 
    }
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
        it { should have_content('Znaleziono') }
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

  #testy strony edycji
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      
      ###Authorization
      visit zaloguj_path(user)
      valid_signin(user)

      visit edit_user_path(user)
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "user_name", with: new_name
        fill_in "user_email", with: new_email
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password
        click_button "Zapisz zmiany"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Wylogowanie', href: wyloguj_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "index" do

    # testprzed zmiana wszyscy userzy na jednej stronie
    # before do
    #   visit zaloguj_path
    #   valid_signin FactoryGirl.create(:user)
    #   FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
    #   FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
    #   visit users_path
    # end

    #po zmiane Factory file tworzy wielu uzytkownikow
    let(:user) { FactoryGirl.create(:user) }
    before(:all)  { 30.times { FactoryGirl.create(:user) } }
    after(:all)   { User.delete_all } 

    before(:each) do
      visit zaloguj_path
      valid_signin user
      visit users_path
    end

    it { should have_selector('title', text: 'Wszyscy uzytkownicy') }
    it { should have_selector('h3',text: 'Wszyscy uzytkownicy') }
    
    # test przed zmiana wszyscy userzy na jednej stronie
    # it "should list each user" do
    #   User.all.each do |user|
    #     page.should have_selector('li', text: user.name)
    #   end
    # end

    #po zmiane Factory file tworzy wielu uzytkownikow
    describe "pagination" do
        it { should have_selector('div.pagination') }
        it "should list each user" do
          User.paginate(page: 1).each do |user|
            page.should have_selector('li', text: user.name)
          end
        end
    end

    describe "delete links" do
      it { should_not have_link('usun') }
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          visit zaloguj_path
          valid_signin admin
          visit users_path
        end

        it { should have_link('usun', href: user_path(User.first)) }
        
        it "should be able to delete another user" do
          expect { click_link('usun') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('usun', href: user_path(admin)) }
      end
    end
  end


end
