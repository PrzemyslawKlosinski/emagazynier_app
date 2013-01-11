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

  	it { should have_selector('h1',text: 'Rejestracja') }
  	it { should have_selector('title', text: caly_tytul('Rejestracja')) }
  end

end
