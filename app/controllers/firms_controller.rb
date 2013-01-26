class FirmsController < ApplicationController

  before_filter :signed_in_user #, only: [:index, :edit,:update, :destroy]

  # GET /firms
  # GET /firms.json
  def index

    #jesli ustawiona
    # session.delete(:firm)

    # dla formularza new
    @firm = current_user.firms.build if signed_in?
    @locations = @firm.locations

    # @firms = Firm.all
    # dla tabeli index
    @firms = Firm.find(:all, :conditions => ["user_id = ?", current_user.id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @firms }
    end
  end

  # GET /firms/1
  # GET /firms/1.json
  def show
    @firm = Firm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @firm }
    end
  end

  # GET /firms/new
  # GET /firms/new.json
  def new

    # @firm = Firm.new  
    # dla formularza new
    @firm = current_user.firms.build if signed_in?

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @firm }
    end
  end

  # GET /firms/1/edit
  def edit
    
    # dla formularza edit
    @firm = current_user.firms.find(params[:id]) if signed_in?
    @locations = @firm.locations

    # dla tabeli index
    @firms = Firm.find(:all, :conditions => ["user_id = ?", current_user.id])

    #zamiast edit.html.erb wyrenderuj index.html.erb
    render 'index'

  end

  # POST /firms
  # POST /firms.json
  def create
    # @firm = Firm.new(params[:firm])

# def create
# @micropost = current user.microposts.build(params[:micropost])
# if @micropost.save
# flash[:success] = "Micropost created!"
# redirect to root path
# else
# render 'static pages/home'
# end

# redirect_to action_name_resource_path(resource_object, {:param_1 => 'value_1', :param_2 => 'value_2'})
# #You can also use the object_id instead of the object
# redirect_to action_name_resource_path(resource_object_id, {:param_1 => 'value_1', :param_2 => 'value_2'})
# #if its a collection action like index, you can omit the id as follows
# redirect_to action_name_resource_path({:param_1 => 'value_1', :param_2 => 'value_2'})
# #An example with nested resource is as follows:
# redirect_to edit_user_project_path(@user, @project, {:param_1 => 'value_1', :param_2 => 'value_2'})
# przekierowuje wszystkie parametry z poprzedniego formularza do nowego

      # TO ZWERYFIKOWAC - dane pobrane jako obiekt z pol formularza i przekazane jako obiekt      
      # redirect_to new_location_path(@firm => params[@firm])

      # by request (all parameters)
      # redirect_to new_location_path(request.parameters) 
      # redirect_to new_location_path(params.except(:product))
      # params.delete :company  ,    # params[:user].delete :company
      # by flash
      # redirect_to edit_user_path(current_user), notice: "Prosze ustawic haslo." -> dostep flash[:notice]
      # redirect_to edit_user_path(current_user), firm: "Prosze ustawic haslo." -> 
      # redirect_to new_location_path(:firm => params[:firm]) -> dostep flash[:firm]
      # by session
      # session.delete(:firm)
      # session[:firm]=nil
      # session[:firm] = @firm

    # dla formularza new - podstawiamy location_id z selecta (uwaga na mass-assign)
    @firm = current_user.firms.build(name: params[:firm][:name], www: params[:firm][:www], email: params[:firm][:email]) if signed_in?


respond_to do |format|
    if @firm.save
      # debugowanie -> logger.debug (sprawdzac w logach)  
      session[:firm] = @firm      
      format.html { redirect_to new_location_path() }
    else
        # format.html { render action: "new" }
        format.html { render action: 'index' }
        format.json { render json: @firm.errors, status: :unprocessable_entity }  
    end
end
    


    # respond_to do |format|
    #   if @firm.save
    #     format.html { redirect_to @firm, notice: 'Firm was successfully created.' }
    #     format.json { render json: @firm, status: :created, location: @firm }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @firm.errors, status: :unprocessable_entity }
    #   end
    # end


  end

  # PUT /firms/1
  # PUT /firms/1.json
  def update
    # @firm = Firm.find(params[:id])
    @firm = current_user.firms.find(params[:id]) if signed_in?

    respond_to do |format|      
      if @firm.update_attributes(params[:firm])

        if params[:firm][:current_address_id].blank?
          session[:firm] = @firm      
          format.html { redirect_to new_location_path() }
        end

        format.html { redirect_to firms_path, notice: 'Firma pomyslnie zaktualizowana.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firms/1
  # DELETE /firms/1.json
  def destroy

# <% if current user?(feed item.user) %>
# <%= link to "delete", feed item, method: :delete,
# confirm: "You sure?",
# title:
# feed item.content %>
# <% end %>
# def destroy
# @micropost.destroy
# redirect back or root path
# end
# private
# def correct user
# @micropost = current user.microposts.find by id(params[:id])
# redirect to root path if @micropost.nil?
# end




    @firm = Firm.find(params[:id])
    @firm.destroy

    respond_to do |format|
      format.html { redirect_to firms_url }
      format.json { head :no_content }
    end
  end
end
