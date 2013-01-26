class UnitsController < ApplicationController

  #Autentykacja
  before_filter :signed_in_user #trzeba byc zalogowanym, tylko swoje przez edycja akcji

  # GET /units
  # GET /units.json
  def index
    # @units = Unit.all

    # dla formularza new
    @unit = current_user.units.build if signed_in?

    # dla tabeli index
    @units = Unit.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @units }
    end
  end

  # GET /units/1
  # GET /units/1.json
  def show
    @unit = Unit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unit }
    end
  end

  # GET /units/new
  # GET /units/new.json
  def new
    @unit = Unit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unit }
    end
  end

  # GET /units/1/edit
  def edit

    # dla formularza edit
    @unit = Unit.find(params[:id])

    # dla tabeli index
    @units = Unit.find(:all, :conditions => ["\"isDefault\" = ? or user_id = ?", true, current_user.id])

    render 'index'

  end

  # POST /units
  # POST /units.json
  def create
    # @unit = Unit.new(params[:unit])
    @unit = current_user.units.build(params[:unit])

    respond_to do |format|
      if @unit.save
        # format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
        format.html { redirect_to units_path, notice: 'Pomyslnie utworzono jednostke.' }
        format.json { render json: @unit, status: :created, location: @unit }
      else
        # format.html { render action: "new" }
        format.html { redirect_to units_path, :flash => { :error => 'Nie udalo sie utworzyc jednostki' } }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /units/1
  # PUT /units/1.json
  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        # format.html { redirect_to @unit, notice: 'Unit was successfully updated.' }
        format.html { redirect_to units_path, notice: 'Pomyslnie zaktualizowano jednostke.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.html { redirect_to units_path, :flash => { :error => 'Nie udalo sie zaktualizowac jednostki' } }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to units_url }
      format.json { head :no_content }
    end
  end
end
