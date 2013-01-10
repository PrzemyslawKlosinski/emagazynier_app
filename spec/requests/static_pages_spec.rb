require 'spec_helper'

describe "StaticPages" do

 #test wygenerowany automatycznie przez RSpec
  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get static_pages_index_path
      response.status.should be(200)
    end
  end


  #moje testy z Capybara
  let(:base_title) { "EMagazynier" }

  describe "Home page" do
    before { visit root_path }

  	it "should have the content 'EMagazynier App'" do
  		page.should have_content('EMagazynier App')
  	end

    it "strona powinna zwierac tytul 'EMagazynier'" do
      page.should have_selector('title', text: caly_tytul(''))
    end

    it "strona NIE powinna zwierac tytul 'EMagazynier | Home'" do
      page.should_not have_selector('title', :text => "#{base_title} | Home" )
    end
  end


  #zmieniamy format zapisu na format it, dodajac subject { page } 
  subject { page }


  describe "How page" do
    before { visit jak_path }

    it { should have_selector('h1', :text => 'Jak to dziala') }
    it { should have_selector('title', :text => caly_tytul('Jak to dziala')) }    
  end


  describe "Pricing page" do
    before { visit cennik_path }

    it { should have_selector('h1', :text =>'Cennik') }
    it { should have_selector('title', :text => caly_tytul('Cennik')) }
  end


  describe "Help page" do
    before { visit pomoc_path }

    it { should have_selector('h1', :text =>'Pomoc') }
    it { should have_selector('title', :text => caly_tytul('Pomoc')) }
  end


  describe "strone Kontakt" do
    before { visit kontakt_path }

    it { should have_selector('h1', :text =>'Kontakt') }
    it { should have_selector('title', :text => caly_tytul('Kontakt')) }
  end  

end
