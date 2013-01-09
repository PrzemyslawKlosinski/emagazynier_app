require 'spec_helper'

describe "StaticPages" do

 let(:base_title) { "EMagazynier" }

  describe "GET /static_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get static_pages_index_path
      response.status.should be(200)
    end
  end

  describe "Home page" do
  	it "should have the content 'EMagazynier App'" do
  		visit '/static_pages/home'
  		page.should have_content('EMagazynier App')
  	end

    it "strony powinna zwierac tytul 'EMagazynier'" do
      visit static_pages_home_path
      page.should have_selector('title', :text => "#{base_title}")
    end
  end

  describe "How page" do
    it "should have the content 'Jak to dziala'" do
      visit '/static_pages/how'
      page.should have_selector('h1', :text => 'Jak to dziala')
    end

    it "strony powinna zwierac tytul 'EMagazynier | Jak to dziala'" do
      visit static_pages_how_path
      page.should have_selector('title', :text => "#{base_title} | Jak to dziala")
    end
  end

    describe "Pricing page" do
    it "should have the content 'Cennik'" do
      visit '/static_pages/pricing'
      page.should have_content('Cennik')
    end

    it "strony powinna zwierac tytul 'EMagazynier | Cennik'" do
      visit static_pages_pricing_path
      page.should have_selector('title', :text => "#{base_title} | Cennik")
    end
  end

  describe "Help page" do
    it "should have the content 'Pomoc'" do
      visit '/static_pages/help'
      page.should have_content('Pomoc')
    end

    it "strony powinna zwierac tytul 'EMagazynier | Pomoc'" do
      visit static_pages_help_path
      page.should have_selector('title', :text => "#{base_title} | Pomoc")
    end
  end

  describe "strone Kontakt" do
    it "strona powinna zawierac napis 'Kontakt'" do
      visit static_pages_contact_path
      page.should have_content('Kontakt')
    end

    it "strony powinna zwierac tytul 'EMagazynier | Kontakt'" do
      visit static_pages_contact_path
      page.should have_selector('title', :text => "#{base_title} | Kontakt")
    end
  end  

end
