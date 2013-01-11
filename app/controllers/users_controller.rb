class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
    if(@user.save)
  	  #jesli sie udalo przejdz do strony show / domyslanie pokaz komunikat o wyslanym mailu
      flash[:success] = 'Witaj w aplikacji EMagazynier! Odbierz email i dokoncz rejestracje.'
  	  redirect_to @user
    else
      #wyrenderuj partial 
      render 'new'
    end
  end

  #wyswietla profil nowego uzytkownika
  def show
	@user = User.find(params[:id])
  end

end
