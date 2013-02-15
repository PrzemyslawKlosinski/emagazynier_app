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
    if !params[:income].nil? && !params[:outcome].nil? && !params[:correct].nil? && !params[:local].nil?
      is_income = false
      is_income = true if params[:income] == "true"
      is_outcome = false
      is_outcome = true if params[:outcome] == "true"
      is_correct = false
      is_correct = true if params[:correct] == "true"
      is_local = false
      is_local = true if params[:local] == "true"
      @documents = Document.search_income(is_income, is_outcome, is_correct, is_local, current_user.id, params[:page])
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


  # Upload document files
  def uploadform
    @document_name = params[:name]
  end

  def uploadsave
    
    # @documents = Document.search(params[:search], current_user.id, params[:page])

    test_file = params[:excel_file]
    puts test_file
    @name = test_file.original_filename
    file = DocumentsUploader.new


    #przekopiowac z formularza
    # @document = current_user.documents.build(:nparams[:name]) if signed_in?
    @document = current_user.documents.build if signed_in?
    @document.name = (current_user.documents.where(is_income: true).where(is_local: false).where(is_correct: false).maximum('name').to_i + 1).to_s
    @document.prefix = 'PZ/'
    @document.title = @document.prefix+@document.name
    # @documents = 


    #obsluzyc wyjatek CarrierWave::IntegrityError
    if file.store!(test_file)
      render action: 'new'
    else
      render action: 'uploadform'
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
      @document.is_local = params[:is_local]
      if @document.is_income
        @document.name = (current_user.documents.where(is_income: true).where(is_local: false).where(is_correct: false).maximum('name').to_i + 1).to_s
        @document.prefix = 'PZ/'
        if @document.is_local
          @document.name = (current_user.documents.where(is_income: true).where(is_local: true).where(is_correct: false).maximum('name').to_i + 1).to_s
          @document.prefix = 'PW/'
        end
        if @document.is_correct
          @document.name = (current_user.documents.where(is_income: true).where(is_local: false).where(is_correct: true).maximum('name').to_i + 1).to_s
          @document.prefix = 'PZk/'
        end
      end
      if @document.is_outcome
        @document.name = (current_user.documents.where(is_income: false).where(is_local: false).where(is_correct: true).maximum('name').to_i + 1).to_s
        @document.prefix = 'WZ/'
        if @document.is_local
          @document.name = (current_user.documents.where(is_income: false).where(is_local: true).where(is_correct: false).maximum('name').to_i + 1).to_s
          @document.prefix = 'RW/'
        end
        if @document.is_correct
          @document.name = (current_user.documents.where(is_income: false).where(is_local: false).where(is_correct: true).maximum('name').to_i + 1).to_s
          @document.prefix = 'WZk/'
        end
      end

      @document.title = @document.prefix+@document.name

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
        
        #aktualizuj stan magazynowy
        @product.quantity = @product.quantity + v[:amount].to_f
        @product.summaryQuantityPurchase = @product.summaryQuantityPurchase + v[:amount].to_f

        #aktualizuj cene zakupu, jesli ma aktualizowac
        if @product.actualPriceOnPurchase
          @product.productPrice.nettoPurchasePrice = v[:netto_price].to_f
          #policz cene zakupu z vat
          vat = (@product.defaultVat / 100) + 1
          @product.productPrice.bruttoPurchasePrice =  vat * v[:netto_price].to_f


                   @product.productPrice.save!
          # @product.defaultIncrease = v[:brutto_price]
 

       #zaktualizuj faktyczna marze po sprzedazy [zmiana ilosc + ewentualnie zmiana ceny] (i daj komunikat)
       # @product.discount = countDiscount(@product)



        end
          





          # #aktualizuj cene sprzedazy na podstawie biezacej marzy, jesli ma aktualizowac
          # if @product.productPrice.calculateByPurchase
          #     discount = @product.discount
          #     #cena sprzedazy ze znizka
          #     netto_with_discount = (((discount/100.00)+1.00)*@product.productPrice.nettoPurchasePrice)
          #     @product.productPrice.nettoSalesPrice = netto_with_discount
          #     #policz cene sprzedazy z vat
          #     vat = (@product.defaultVat / 100) + 1
          #     @product.productPrice.bruttoSalesPrice = vat * netto_with_discount
          # end

          #docelowo - powinien prognozowac i dostosowywac cene sprzedazy do ustawionej marzy, a nie ja zmieniac
          #zaktualizuj faktyczna marze na podstawie nowego zakupu i ceny sprzedazy (i daj komunikat)
          # @product.discount = countDiscount(@product)  






        
      end

      #jesli rozchod - nie aktualizuj ceny artykulu po sprzedazy
      if @document.is_outcome
        @product.quantity = @product.quantity - v[:amount].to_f
        # @product.defaultIncrease = @product.defaultIncrease - v[:brutto_price].to_f 
        # abs() remove negative sign
        @product.summaryQuantitySales = @product.summaryQuantitySales + v[:amount].to_f






        # aktualizuj cene sprzedazy na podstawie sprzedazy, jesli ma aktualizowac

        if @product.productPrice.calculateByPurchase
          @product.productPrice.nettoSalesPrice = v[:netto_price].to_f
          #policz cene zakupu z vat
          vat = (@product.defaultVat / 100) + 1
          @product.productPrice.bruttoSalesPrice =  vat * v[:netto_price].to_f


              @product.productPrice.save!

     #zaktualizuj faktyczna marze po sprzedazy [zmiana ilosc + ewentualnie zmiana ceny] (i daj komunikat)
      # @product.discount = countDiscount(@product)

 

        end



          





        
        zdejmij = v[:amount].to_f

        while (zdejmij > 0)
        #zdejmuj ze stanu
        #pobierz dokumenty przychodzace dla produktu
        documents = @product.documents.where(is_income: true).order("created_at ASC")
      
        #dla kazdego dokumentu sprobuj wybrac pierwsze wolne quantity, jesli jest przerwij
        quantity = nil
        documents.each do |document|
            quantity = document.quantities.where("product_id = ?", @product.id).where("unsold > ?", 0).order("created_at ASC").first
            #wybierz quantity ktore ma ten dokument i ten produkt, zdejmij quantity
            if !quantity.nil?
              break;
            end
        end

        #jesli nie znaleziono zadnego quantity i jest to dokument outcome, to znaczy ze 'wystapil blad': w produkcie jest quantity wieksze niz faktycznie w quantities
        if !quantity.nil?
          quantity.unsold = quantity.unsold - zdejmij
          if quantity.unsold < 0
            zdejmij = -(quantity.unsold)
            quantity.unsold = 0
          else
            zdejmij = 0
          end
          quantity.save!
        end
        
        end
        




      end






      @product.save!
    end
    end

        # format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.html { redirect_to documents_path, notice: 'Dokument pomyślnie utworzony.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

#metoda do aktualizowania marzy
def countDiscount(product)

  #wybieramy wszystkie quantities dla produktu (przy przegladanie wybieramy jesli ma unsold - brak optymalizacji)
  quantities = product.quantities
 

  unsold_value = 0
  quantities_value = 0
  # pobieramy wszystkie quantity: zakupu produktu i ktore maja ilosc niesprzedana != 0
  quantities.each do |quantity|

    #jesli quantity jest income i ma unsold
    if (quantity.unsold != 0 and quantity.document.is_income)

      unsold_value = unsold_value + quantity.unsold
      #quantity.discount wylicza discount == (cena sprzedazy - cena zakupu/cena_zakupu)*unsold

      #obliczanie znizki dla danego quantity zwiazanego z danym produktem
      quantity_discount = ((product.productPrice.nettoSalesPrice - quantity.netto_price)/quantity.netto_price) * quantity.unsold

      #sumowanie discount
      quantities_value = quantities_value + quantity_discount

    end

  end


  #jesli nie ma juz produktow to marze bedziemy mieli 0


  return ((quantities_value / unsold_value) * 100)
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

    if params[:dates][:print_all] == '1'
        # pdf = Prawn::Document.new 
        # view = "testowy napis"
        pdf = DocumentsPdf.new(@documents, view_context, @start_date, @end_date)
        send_data pdf.render, filename: 
        "documents_report_#{Time.now.strftime("%d/%m/%Y")}.pdf", type: "application/pdf", disposition: "inline"
    else 
        render 'new_report'
    end

  end

end
