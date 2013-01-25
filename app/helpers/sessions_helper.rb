module SessionsHelper

	def sign_in(user)
		# Przy pomocy sesji (tymczasowych cookies)
  		# One technique for maintaining the user signin status is to use a traditional Rails session (via the special session function) to store a #remember token equal to the user’s id: This session object makes the user id available from page to page by storing it in acookie that #expires upon browser close. On each page, the application could simply call
  		# session[:remember_token] = user.remember_token
  		# pobranie TOKENA = User.find_by_remember_token(session[:remember_token])

		# Przy pomocy stalych cookies
		# cookies[:remember_token] = { value:user.remember_token, expires: 20.years.from_now.utc }
		cookies.permanent[:remember_token] = user.remember_token

		#The purpose of this line is to create current_user, accessible in both controllers and
		#views, which will allow constructions such as <%= current_user.name %>
		#ustawiamy zmienna current_user
		self.current_user = user
		# pobranie TOKENA =  User.find_by_remember_token(cookies[:remember_token])
	end


	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end


	def signed_in?
		#symulacja uzytkownik zalogowany
		# @current_user = User.find_by_name("EMAGAZYNIER2") lub
		# self.current_user = User.find_by_name("EMAGAZYNIER2") (wykorzysta metoda a nie utworzy lokalna zmienna)
		!current_user.nil?	#metoda ktora zwraca @current_user a nastepnie jest pytanie czy jest nil?
	end


   	###Authorization - przekieruj do strony zaloguj jesli uzytkownik niezalogowany
   	#przeniesione z  users_helper.rb
  	def signed_in_user
  		#zapisuje adres z jakiego przyszlismy
  		unless signed_in?
  			store_location
  			redirect_to zaloguj_path, notice: "Prosze sie zalogowac."
  		end
  	end

	###Authorization
	def current_user?(user)
		user == current_user
	end

	#Redirect path saver - zapamietujemy sciezke i ja odczytujemy z sesji, aby do niej wrocic, po redirect
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
	def store_location
		session[:return_to] = request.fullpath
	end


	#Its effect is to set the @current_user instance variable to the user corresponding to the remember token, but only if @current_user is undefined.
	#Typically, this means assigning to variables that are initially nil, but note that false values will also be overwritten by the ||= operator.
	def current_user=(user)
		@current_user = user
	end
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
		#jesli to sie nie udalo sprobuj pobrac z sesji
		@current_user ||= User.find_by_remember_token(session[:remember_token])
	end

end
