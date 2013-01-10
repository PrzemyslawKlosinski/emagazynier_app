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


  describe "Help page" do
    before { visit pomoc_path }

    it { should have_selector('h1', :text =>'Pomoc') }
    it { should have_selector('title', :text => caly_tytul('Pomoc')) }
  end


  #dodajemy shared examples - uwaga inny zapis hash'a
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: naglowek) }
    it { should have_selector('title', text: caly_tytul(tytul_strony)) }
  end


  describe "How page" do
    before { visit jak_path }
    let(:naglowek) { 'Jak to dziala' }
    let(:tytul_strony) { 'Jak to dziala' }

    it_should_behave_like "all static pages"
  end


  describe "Pricing page" do
    before { visit cennik_path }
    let(:naglowek) { 'Cennik' }
    let(:tytul_strony) { 'Cennik' }

    it_should_behave_like "all static pages"
  end


  describe "strone Kontakt" do
    before { visit kontakt_path }
    let(:naglowek) { 'Kontakt' }
    let(:tytul_strony) { 'Kontakt' }

    it_should_behave_like "all static pages"
  end  


  describe "strone rejestracja <-- signup" do
    before { visit rejestracja_path }
    let(:naglowek) { 'Rejestracja' }
    let(:tytul_strony) { 'Rejestracja' }

    it_should_behave_like "all static pages"
  end


  # testy klikniec w poszczegolne linki
  it "should have the right links on the layout" do
    visit root_path
    click_link "Pomoc"
      page.should have_selector 'title', text: caly_tytul('Pomoc')
    click_link "Kontakt"
      page.should have_selector 'title', text: caly_tytul('Kontakt')
    click_link 'Jak to dziala'
      page.should have_selector 'title', text: caly_tytul('Jak to dziala')
    click_link 'Cennik'
      page.should have_selector 'title', text: caly_tytul('Cennik')
  end


end
