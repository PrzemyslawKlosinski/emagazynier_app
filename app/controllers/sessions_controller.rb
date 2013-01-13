class SessionsController < ApplicationController

	def new
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
			flash.now[:error] = 'Nie udane logowanie. Sprawdz email oraz haslo'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
