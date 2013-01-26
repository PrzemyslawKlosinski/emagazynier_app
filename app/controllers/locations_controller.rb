class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

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
        # session[:location] = @location


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



    # @location = Location.new(params[:location])
    @location = current_user.location.build(params[:location]) if signed_in?

    # respond_to do |format|
    #   if @location.save
    #     format.html { redirect_to @location, notice: 'Location was successfully created.' }
    #     format.json { render json: @location, status: :created, location: @location }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @location.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
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
