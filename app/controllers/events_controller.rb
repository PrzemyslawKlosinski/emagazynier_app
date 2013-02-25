# encoding: utf-8
class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    # @events = Event.all

    #jesli wprowadzono dane do button search, jesli tekst pusty i tak zwroc mape products
    @events = current_user.events.search(params[:search], params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    if !params[:name].nil?
      @worker = Worker.find(params[:name])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @product = Product.find(params[:name])
    @event = Event.new(product_id: @product_id)

    #to make validates - amount if hidden
    @description = ''
    @amount = 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @product = Product.find(params[:event][:product_id])


    if !@product.isEvent
      # params[:event][:start_at] = DateTime.now
      @event.start_at = DateTime.now
    end    

    if @product.isEvent and !@event.start_at.nil?
      # YYYY-MM-DD HH:MM:SS
      @start_at = DateTime::strptime(params[:event][:start_at], "%Y-%m-%d %H:%M")
      @event.start_at = @start_at

      #dodajemy godziny
      @end_at =  @product.realization.to_i.hours.since @start_at
      @event.end_at = @end_at
    end


  

    respond_to do |format|
      if @event.save

        NotificationsMailer.new_message(@event, @product).deliver
        @event.email = @product.user.email
        NotificationsMailer.new_message(@event, @product).deliver
        
        format.html { redirect_to @event, notice: 'Potwierdzenie zamówienia zostało wysłane na podany adres.' }
        format.json { render json: @event, status: :created, location: @event }
      else

      
      #jesli blad typu start_at, zaproponuj inne terminy w tym dniu lub wyswietl brak terminu
      if(@event.errors.include?(:start_at) and !@event.start_at.nil?)
        $i = 0
        $num = 10

        @start_at_prop = @event.start_at
        @end_at_prop = @event.end_at
        while $i < $num  do
          # @propzycja
          @start_at_prop = 1.hours.since @start_at_prop
          @end_at_prop = 1.hours.since @end_at_prop

          events = Event.where("worker_id = ?", @event.worker_id).where("(start_at BETWEEN '#{@start_at_prop}' AND '#{@end_at_prop}' ) OR (end_at BETWEEN '#{@start_at_prop}' AND '#{@end_at_prop}')")
          if events.empty?
            @prop_date = @start_at_prop
            break;
          end
          $i +=1
        end
      end


        # flash.now.alert = "Proszę wypełnić wszystkie pola."
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Zaktualizowano termin realizacji usługi.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
