# encoding: utf-8

class DocumentsController < ApplicationController

before_filter :signed_in_user

  # GET /documents
  # GET /documents.json
  def index
    
    # dla formularza new
    # @documents = Document.all
    @document = current_user.documents.build if signed_in?

    # dla tabeli index
    # Document.find(:all, :conditions => ["user_id = ?", current_user.id])
    # @documents = current_user.documents.paginate(page: params[:page])

    #jesli wprowadzono dane do button search, jesli tekst pusty i tak zwroc mape documents
    @documents = Document.search(params[:search], current_user.id, params[:page])

    #jesli wyszukujemy konkretny rodzaj dokumentu - nadpisz zwrocone documents
    if !params[:income].nil? && !params[:outcome].nil? && !params[:correct].nil?
      is_income = false
      is_income = true if params[:income] == "true"
      is_outcome = false
      is_outcome = true if params[:outcome] == "true"
      is_correct = false
      is_correct = true if params[:correct] == "true"
      @documents = Document.search_income(is_income, is_outcome, is_correct, current_user.id, params[:page])
    end



# def self.search(search, page)
#   paginate :per_page => 5, :page => page,
#            :conditions => ['name like ?', "%#{search}%"],
#            :order => 'name'
# end


    
    #for quantity_fields
    # @products = @current_user.products

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])
    @quantities = @document.quantities
    @products = @document.products


    respond_to do |format|
      
      format.html # show.html.erb
      
      format.json { render json: @document }

      format.pdf do
        pdf = DocumentPdf.new(@document, view_context)
        send_data pdf.render, filename: 
        "document_#{@document.name}_#{@document.created_at.strftime("%d/%m/%Y")}.pdf",
        type: "application/pdf", disposition: "inline"
        # , disposition: "inline - otworz w przegladarce zamiast pobierac
      end

    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new

    # dla formularza new
    # @document = Document.new
    @document = current_user.documents.build if signed_in?

    # dla tabeli index
    # @documents = Document.find(:all, :conditions => ["user_id = ?", current_user.id])
    
    #for quantity_fields
    # @products = @current_user.products if signed_in?

    #for _form
    # @firms = @current_user.firms

      #ustawienie rodzaju dokumentu
      @document.is_correct = params[:is_correct]
      @document.is_income = params[:is_income]
      @document.is_outcome = params[:is_outcome]
      if @document.is_income
        @document.name = "PZ/" + (Document.maximum("id").to_i + 1).to_s
        if @document.is_correct
          @document.name = "PZk/" + (Document.maximum("id").to_i + 1).to_s
        end
      end
      if @document.is_outcome
        @document.name = "WZ/" + (Document.maximum("id").to_i + 1).to_s
        if @document.is_correct
          @document.name = "WZk/" + (Document.maximum("id").to_i + 1).to_s
        end
      end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])

    @documents = Document.search(params[:search], current_user.id, params[:page])

    #for quantity_fields
    # @products = @current_user.products if signed_in?

    #for _form
    # @firms = @current_user.firms
    render 'new'

  end

  # POST /documents
  # POST /documents.json
  def create
    # @document = Document.new(params[:document])
    @document = current_user.documents.build(params[:document]) if signed_in?

    @document.document_date = Time.new 

    #for _form
    # @firms = @current_user.firms


    #podsumuj kwoote netto i brutto dla dokumentu (suma pozycji)
    @netto_sum = 0.00
    @brutto_sum = 0.00
    if !params[:document][:quantities_attributes].nil?
    params[:document][:quantities_attributes].each do |k,v|
      amount = v[:amount].to_f
      netto_price = v[:netto_price].to_f
      brutto_price = v[:brutto_price].to_f
      @netto_sum = @netto_sum + (amount*netto_price)
      @brutto_sum = @brutto_sum + (amount*brutto_price)
    end
      @document.netto_value = @netto_sum
      @document.brutto_value = @brutto_sum
      # @document.save!
    end


    respond_to do |format|
      if @document.save

    #aktualizacja stanu magazynowego (i ostatniej ceny zakupu) artykulu po edycji documenty magazynwoego
    if !params[:document][:quantities_attributes].nil?
    params[:document][:quantities_attributes].each do |k,v|
      @product = Product.find(v[:product_id])
      #jesli przychod - tylko aktualizacja ceny produktu przy zakupie (uwaga dorobic podpowiadanie ceny)
      if @document.is_income 
        @product.quantity = @product.quantity + v[:amount].to_f
        @product.defaultIncrease = v[:brutto_price]
        @product.summaryQuantityPurchase = @product.summaryQuantityPurchase + v[:amount].to_f
      end
      #jesli rozchod - nie aktualizuj ceny artykulu po sprzedazy
      if @document.is_outcome
        @product.quantity = @product.quantity - v[:amount].to_f
        # @product.defaultIncrease = @product.defaultIncrease - v[:brutto_price].to_f 
        # abs() remove negative sign
        @product.summaryQuantitySales = @product.summaryQuantitySales + v[:amount].to_f
      end
      @product.save!
    end
    end

        # format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.html { redirect_to documents_path, notice: 'Dokument został pomyślnie utworzony.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    #ewentualnie dodac mozliwosc edycji dokumentu, wytedy 
    # - dopisac ze jesli zmniejszamy stan to zmniejszyc stan magazynowy
    # - dopisac ze jesli zwiekszamy stan to zwiekszamy stan magazynowy

    # #ustawienie rodzaju dokumentu
    # if params[:document][:doctype] == 0 or params[:document][:doctype] == 1 or params[:document][:doctype] == 2
    #   @document.is_income = true
    # end

    # if params[:document][:doctype] == 3 or params[:document][:doctype] == 4 or params[:document][:doctype] == 5
    #   @document.is_outcome = true
    # end

    # if params[:document][:doctype] == 2 or params[:document][:doctype] == 5
    #   @document.is_correct = true
    # end

    # NIE MOZNA EDYTOWAC DOKUMENTU - poprawic + / -
    # podsumuj kwote netto i brutto
    # @netto_sum = 0.00
    # @brutto_sum = 0.00
    # if !params[:document][:quantities_attributes].nil?
    # params[:document][:quantities_attributes].each do |k,v|
    #   amount = v[:amount].to_f
    #   netto_price = v[:netto_price].to_f
    #   brutto_price = v[:brutto_price].to_f
    #   @netto_sum = @netto_sum + (amount*netto_price)
    #   @brutto_sum = @brutto_sum + (amount*brutto_price)
    # end
    #   params[:document][:netto_value] = @netto_sum
    #   params[:document][:brutto_value] = @brutto_sum
    # end


  respond_to do |format|
    if @document.update_attributes(params[:document])

    # NIE MOZNA EDYTOWAC DOKUMENTU - poprawic + / -
    # #aktualizacja stan magazynowego artykulu po edycji documenty magazynwoego
    # if !params[:document][:quantities_attributes].nil?
    # params[:document][:quantities_attributes].each do |k,v|
    #   @product = Product.find(v[:product_id])
    #   #jesli przychod
    #   if @document.is_income 
    #     @product.quantity = @product.quantity + v[:amount].to_f
    #     # @product.defaultIncrease = @product.defaultIncrease + v[:brutto_price].to_f
    #   end
    #   #jesli rozchod
    #   if @document.is_outcome
    #     @product.quantity = @product.quantity - v[:amount].to_f
    #     # @product.defaultIncrease = @product.defaultIncrease - v[:brutto_price].to_f
    #   end
    #   @product.save!
    # end
    # end

        # format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.html { redirect_to documents_path, notice: 'Dokument został pomyślnie zaktualizowany.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])

    #usuwanie ilosc z produktow
    @document.quantities.each do |quantity|
      # quantity.product.defaultIncrease = quantity.product.defaultIncrease - quantity.brutto_price
      quantity.product.quantity = quantity.product.quantity - quantity.amount
      if @document.is_income 
        quantity.product.summaryQuantityPurchase = quantity.product.summaryQuantityPurchase - quantity.amount
      end
      if @document.is_outcome 
        quantity.product.summaryQuantitySales = quantity.product.summaryQuantitySales - quantity.amount
      end
      quantity.product.save!
    end

    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  #formularz wyszukujacy raporty z okresu
  def new_report
    @start_date = DateTime.now.strftime('%Y-%m-%d')
    @end_date = DateTime.now.strftime('%Y-%m-%d')
    # @start_date_test = Date.today
    # @documents = Document.find(:all, :conditions => ["document_date >= ? AND document_date <= ?", @start_date, @end_date])
    # @start_date = Date::strptime('01-01-2011', "%d-%m-%Y")
    # @end_date = Date::strptime('30-01-2013', "%d-%m-%Y")
    # # @end_date = DateTime.new(2013,01,30,00,00);
    # # @documents = Document.find(:all)
    # # @documents = Document.where(:created_at => @start_date..@end_date)
    # @documents = Document.find(:all, :conditions => ["document_date >= ? AND document_date <= ?", @start_date, @end_date])
  end

  def create_report
    # @start_date = Date::strptime(params[:start_date], "%d-%m-%Y")
    # @end_date = params[:end_date]

    # @start_date = DateTime.now.strftime('%Y-%m-%d')
    # @end_date = DateTime.now.strftime('%Y-%m-%d')
    @start_date = Date::strptime(params[:start_date], "%Y-%m-%d")
    @end_date = Date::strptime(params[:end_date], "%Y-%m-%d")

    # @end_date = DateTime.new(2013,01,30,00,00);
    # @documents = Document.find(:all)
    # @documents = Document.where(:created_at => @start_date..@end_date)
    @documents = Document.find(:all, :conditions => ["document_date >= ? and document_date <= ?", @start_date.strftime('%Y-%m-%d 00:00:00'), @end_date.strftime('%Y-%m-%d 24:00:00') ])

    render 'new_report'
    # #dorobic generowanie z automatu dla zakresu dat
    # pdf = Prawn::Document.new 
    # #przerobic aby konstruktor otrzymal @documents, nie @document
    # view = "testowy napis"
    # pdf = Prawn:DocumentPdf.new(@documents, view)
    # # niepotrzebne - pdf.text @documents
    # send_data pdf.render

  end

end
