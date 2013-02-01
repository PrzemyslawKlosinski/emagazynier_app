# encoding: utf-8
class ShopsController < ApplicationController

	def index
    	@shops = User.search(params[:page])
	end

	#po id
	def firm
		@user = User.find(params[:name])
		# @user = User.find(:first, :conditions => ["email like ?", "%#{params[:name]}@%"])
		@categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, @user.id])
		@products = @user.products.paginate(page: params[:page])
	end

	#pod email - zmienic klucz wyszukiwania, dodatkowa kolumna od sql regex
	def firmemail
		# @user = User.find(params[:id])
		@user = User.find(:first, :conditions => ["email like ?", "%#{params[:name]}@%"])
		@categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, @user.id])
		@products = @user.products.paginate(page: params[:page])

		render 'firm'
	end

	def new_order
		@message = Message.new
		@product = Product.find(params[:name])

    	# respond_to do |format|
     #  		format.html # show.html.erb
     #  		format.json { render json: @product }
    	# end
	end

	def create_order
		@message = Message.new(params[:message])
		@product = Product.find(params[:name])

		if @message.valid?
			NotificationsMailer.new_message(@message, @product).deliver
			 redirect_to(sklepy_path, :notice => "Zamówienie zostało wysłane.")
		else
		 flash.now.alert = "Proszę wypełnić wszystkie pola."
		 render :new_order
		end
	end

end