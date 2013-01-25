include ApplicationHelper

	#metoda pomocnicza do podstawiania tytulu (jak w helperze) 
	def caly_tytul(page_title)
		poczatek_tytulu = "EMagazynier"
		if(page_title.empty?)
			return poczatek_tytulu
		else
			return "#{poczatek_tytulu} | #{page_title}"
		end
	end


	#metody dla testów RSPEC wykorzystane w spec/requests/authentication_pages_spec.rb
	def valid_signin(user)
		fill_in "session_email", with: user.email
		fill_in "session_password", with: user.password
		click_button "Logowanie"
		
		# Sign in when not using Capybara as well.
		cookies[:remember_token] = user.remember_token
	end

	RSpec::Matchers.define :have_error_message do |message|
		match do |page|
			page.should have_selector('div.alert.alert-error', text: message)
		end
	end
