# encoding: utf-8
class ProductsController < ApplicationController
  
  #Autentykacja
  # before_filter :correct_user
  before_filter :signed_in_user #trzeba byc zalogowanym, tylko swoje przez edycja akcji

  # GET /products
  # GET /products.json
  def index
    
    # dla formularza new
    @product = current_user.products.build if signed_in?
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])
    @units = Unit.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])

    # dla tabeli index
    # @products = Product.all
    # @products = Product.find(:all, :conditions => ["user_id = ?", current_user.id])
    # @products = Product.find_all_by_user_id(current_user.id);
    # @products = @current_user.products.paginate(page: params[:page])

    #jesli wprowadzono dane do button search, jesli tekst pusty i tak zwroc mape products
    @products = Product.search(params[:search], current_user.id, params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def shop

    @product = Product.find(params[:id])
    @firm = product.firm
    @user = User.find(:first, :conditions => ["email like ?", "%#{params[:name]}@%"])
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, @user.id])
    @products = @user.products.paginate(page: params[:page])

    @shop = @user.email[/[^@]+/]
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new

    #@product = Product.new
    @product = current_user.products.build if signed_in?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    # @product = Product.find(params[:id])

    # dla formularza edit
    @product = Product.find(params[:id])
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])
    @units = Unit.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])


    # dla tabeli index
    @products = current_user.products.paginate(page: params[:page])

    render 'index'

  end

  def editQuantity
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    
    # dla formularza new, dla metody create
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])
    @units = Unit.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])

    #@product = Product.new(params[:product])
    @product = current_user.products.build(params[:product])

    respond_to do |format|
      if @product.save

    #tworzymy domysla cene produktu, kategorie sa domyslne, ceny nie
    # @productPrice = @product.productPrice.build
    @productPrice = ProductPrice.new(product: @product)
    @productPrice.save!
    @product.update_attributes(productPrice: @productPrice)

        # format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.html { redirect_to products_path, notice: 'Pomyślnie utworzono produkt.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        # format.html { render action: "new" }
        format.html { redirect_to products_path, :flash => { :error => 'Nie udało sie utworzyć produktu' }}
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update

    # dla formularza new, dla metody create
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])
    @units = Unit.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])

    @product = Product.find(params[:id])

        # dla tabeli index
    @products = current_user.products.paginate(page: params[:page])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Produkt pomyślnie zaktualizowano.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  # def correct_user
  #   @product = Product.find(params[:id])
  #   redirect_to(root_path) unless current_user?(@product.user)
  # end


# http://net.tutsplus.com/tutorials/javascript-ajax/using-unobtrusive-javascript-and-ajax-with-rails-3/
# Rails will respond to JavaScript requests by loading a .js ERB with the same name as the controller action sales.js.erb
def sales

 @product = Product.find(params[:id])
 @productPrice = @product.productPrice

     respond_to do |format|  
          # format.js { render :layout=>false }
        # format.json { render json: @Item, status: :created, location: @Item 
        format.json { render :json => @productPrice }
    end 
     
end





end

