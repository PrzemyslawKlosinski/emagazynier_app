class LocationsController < ApplicationController

  before_filter :signed_in_user

  # GET /locations
  # GET /locations.json
  def index
    # @locations = Location.all

    #po dodaniu has_many @locations, :through => @firms
    @locations = current_user.locations if signed_in?


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new

      # zbudowac obiekt firm po tej stronie z przekazanych parametrow_firm
      # tu trzeba uwazac na mass_assign jest wykorzystamy new() i bedizemy nadpisywac firm_id (lepiej przez sesje)
      # @firm = current_user.firms.build(params[:firm]) if signed_in?

      # wykrzystac obiekt z sesji
      # session[:firm]=nil
      
      @firm = session[:firm]

      #jesli nie ma powiazanego obiektu firm, to przekaz do firms
      if @firm.nil?
        redirect_to firms_path
      else
        #jesli uzytkonik ma w sesji ciastko firm ale jest niezalogowany przekieruj do logowanie
        @location = @firm.locations.build() if signed_in?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end

      end

  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create

      # @location = session[:location]

      #jesli nie ma powiazanego obiektu firm, to przekaz do firms
      # if @firm.nil?
        # redirect_to firms_path
      # else
        #jesli uzytkonik ma w sesji ciastko firm ale jest niezalogowany przekieruj do logowanie
        # @location = @firm.locations.build(params[:location]) if signed_in?

    #potestowac gdy ktos podmienia sobie cookie i robi put request to update
    @firm = session[:firm]
    # @location = Location.new(params[:location]) if signed_in?
    @location = @firm.locations.build(params[:location]) if signed_in?

    #jesli ktos podmieni cookies musimy wybierac tylko z firm zalogowanego usera
    # @location = @firm.locations.build(params[:location]) if signed_in?
    # @location = @firm.locations.build(params[:location]) if signed_in?

    respond_to do |format|
      if @location.save

        #przypisanie adresu do firmy i usuniecie ciastka
        @location.firm.current_address = @location
        @location.firm.save!
        session.delete(:firm)


        # format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.html { redirect_to firms_path, notice: 'Adres pomyslnie utworzony.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to locations_path, notice: 'Adres pomyslnie zaktualizowany.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end
