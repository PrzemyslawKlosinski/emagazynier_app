class CategoriesController < ApplicationController

  #Autentykacja
  before_filter :signed_in_user 
  #trzeba byc zalogowanym, edycja tylko swoje przez zmiane akcji i metody find(:All) w kontrolerach - ale wtedy zarzadzamy activeadmin
  #jak bedzie potrzeba zrobic zarzadzanie przy pomocy uprawnien admin to dodamy filtr correct_user

  # GET /categories
  # GET /categories.json
  def index

    # dla formularza new
    @category = current_user.categories.build if signed_in?

    # dla tabeli index
    # @categories = Category.all
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new

    #@category = Category.new
    @category = current_user.categories.build if signed_in?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    
    # dla formularza edit
    @category = Category.find(params[:id])

    # dla tabeli index
    @categories = Category.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])

    render 'index'

  end

  # POST /categories
  # POST /categories.json
  def create

    # @category = Category.new(params[:category])
    @category = current_user.categories.build(params[:category])

    respond_to do |format|
      if @category.save
        # format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.html { redirect_to categories_path, notice: 'Pomyslnie utworzono kategorie.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        # format.html { render action: "new" }
        format.html { redirect_to categories_path, :flash => { :error => 'Nie udalo sie utworzyc kategorii' } }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        # format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.html { redirect_to categories_path, notice: 'Pomyslnie zaktualizowano kategorie.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.html { redirect_to units_path, :flash => { :error => 'Nie udalo sie zaktualizowac kategorii' } }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
