class UsersController < ApplicationController

  before_filter :active_user, only: [:edit,:update]
  #Autentykacja
  before_filter :signed_in_user, only: [:index, :destroy] #show pokazuje sklep
  #Autoryzacja
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  #wyswietla liste uzytkownikow
  def index
    # @users = User.all
    #paginate
    @users = User.paginate(page: params[:page])
  end

  #wyswietla profil nowego uzytkownika
  def show
    @user = User.find(params[:id])

    # dla lewego menu
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", "true", @user.id])

    #dodajemy producty na stronie uzytkownika
    #Notice here how clever paginate is—it even works through the microposts association,
    #reaching into the microposts table and pulling out the desired page of microposts.
    @products = @user.products.paginate(page: params[:page])

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Uzytkownik usuniety."
    redirect_to users_path
  end


  def new
  	@user = User.new
  end

  def create
    #temporary password
    pass = SecureRandom.urlsafe_base64
  	
    # @user = User.new(params[:user])
    @user = User.new(password: pass, password_confirmation: pass, email: params[:user][:email])

    if(@user.save)
  	  
      #jesli sie udalo zapisz cookies, przejdz do strony show / domyslanie pokaz komunikat o wyslanym mailu
      flash[:success] = 'Witaj, pomyslnie zarejestrowales sie w aplikacji eMagazynier! Odbierz email i dokoncz rejestracje.'
      
      #zaloguj ciasteczko
      # sign_in @user

      #wyslij email aktywacyjny
      UserMailer.welcome_email(@user).deliver

      #przekieruj uzytkownika na strone glowna
  	  redirect_to root_path
    
    else
      #wyrenderuj partial 
      render 'new'
    end
  end


  #edycja profilu uzytkownika
  def edit
        @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = "Dane podstawowe zaktualizowano."
      #jesli uzytkonik nieaktywny i zmienil haslo, aktywuj
      if !@user.isActive
        @user.toggle!(:isActive)
      end
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  ###Authorization
  private
  # def signed_in_user - przeniesiona do sessions_helper.rb, import w application_controller.rb
  #   #zapisuje adres z jakiego przyszlismy
  #   store_location
  #   redirect_to zaloguj_path, notice: "Prosze sie zalogowac." unless signed_in?
  # end
  #metoda sprawdzajaca przed wywolaniem edit  #metoda sprawdzajaca przed wywolaniem edit
  def correct_user
    @user = User.find(params[:id])
    redirect_to(edit_user_path(@current_user)) unless current_user?(@user)
  end
  #metoda sprawdzajaca przed wywolaniem destroy
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  #metoda pomocnicza sprawdza jak signed_in_user czy user sie zalogowal, ale nie zapetla
  def active_user
      unless signed_in?
        #zapisuje adres z jakiego przyszlismy
        store_location
        redirect_to zaloguj_path, notice: "Prosze sie zalogowac."       
      end
  end

end
