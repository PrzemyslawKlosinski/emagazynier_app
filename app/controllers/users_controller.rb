class UsersController < ApplicationController


  #Authorization
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]


  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
    if(@user.save)
  	  #jesli sie udalo zapisz cookies, przejdz do strony show / domyslanie pokaz komunikat o wyslanym mailu
      flash[:success] = 'Witaj w aplikacji EMagazynier! Odbierz email i dokoncz rejestracje.'
      sign_in @user
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


  #edycja profilu uzytkownika
  def edit
   @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = "Dane podstawowe zaktualizowano."
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  ###Authorization
  private
  def signed_in_user
    #zapisuje adres z jakiego przyszlismy
    store_location
    redirect_to zaloguj_path, notice: "Prosze sie zalogowac." unless signed_in?
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(@current_user) unless current_user?(@user)
  end


end
