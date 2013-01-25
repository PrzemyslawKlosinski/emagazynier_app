class SessionsController < ApplicationController

	def new
	end

	def active
		if params[:id].nil?
			flash.now[:error] = 'Bledny link nieaktywny.' 
			render 'new'
  		else
  			#zdekoduj haslo
  			dec = Base64.decode64(params[:id])
			user = User.find_by_password_digest(dec)

			#jesli uzytkownik znaloziony i nie aktywny, zaloguj i przekieruj do ustawienia hasla
			if !user.nil? and !user.isActive
				sign_in user
				# redirect_to edit_user_path(user, :idc => params[:idc])
				# redirect_to edit_user_path(current_user, notice: "Prosze ustawic haslo.")
				redirect_to edit_user_path(current_user), notice: "Prosze ustawic haslo."
			else
				flash.now[:error] = "Link nieaktywny."
				render 'new'
			end
		end
	end

	def create
		user = User.find_by_email(params[:session][:email])
		# Taking into account that any object other than nil and false itself is true in a boolean context
		if user && user.authenticate(params[:session][:password])
			sign_in user
			#zmienna z sign_in
			# redirect_to current_user - zamiast przekierowac do strony users/:id akcji show, odtwarzamy zapamietana sciezke
			redirect_back_or user
		else
			flash.now[:error] = 'Nieudane logowanie. Sprawdz email oraz haslo'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
