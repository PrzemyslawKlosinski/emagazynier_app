class DocumentPdf < Prawn::Document

include UsersHelper

  def initialize(document, view)
    # super()
    super(top_margin: 70)

    # text "Raport z dokumentu magazynowego"
    @document = document
  	@view = view
  	# text "Document #{@document.id}"
    # @logo = logo(document.user)

    # dla metod
    @quantities = @document.quantities
    @products = @document.products

    document_number
    line_items
    total_price

	# thanks_message
  	#  subscription_date
  	#  subscription_details
  	#  subscription_amount
  	#  regards_message

  end


 def document_number
    text "Dokument \##{@document.name}", size: 40, style: :bold
    text "Data #{@document.document_date}"
  end
  
  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Produkt", 'Ilosc', "Cena jednostkowa (brutto)", "Cena sumaryczna (brutto)"]] +
    @quantities.map do |quantity|
      [quantity.product.name, quantity.amount, price(quantity.brutto_price), price(quantity.brutto_price * quantity.amount)]
    end
  end
  
  def price(num)
    @view.number_to_currency(num)
  end
  
  def total_price
    move_down 15
    text "Podsumowanie: #{price(@document.brutto_value)}", size: 16, style: :bold
  end


# method show logo in pdf
# def logo(user)
  # logopath =  "#{Rails.root}/app/assets/images/logo.png"
  # dopisac metode pobierajaca image z url logopath = gravatar_for user
  # image logopath, :width => 197, :height => 91
# end

# def thanks_message
#     move_down 80
#     text "Hello #{@invoice.customer.profile.first_name.capitalize},"
#     move_down 15
#     text "Thank you for your order.Print this receipt as 
#     confirmation of your order.",
#     :indent_paragraphs => 40, :size => 13
#   end

#   def subscription_date
#     move_down 40
#     text "Subscription start date: 
#     #{@invoice.start_date.strftime("%d/%m/%Y")} ", :size => 13
#     move_down 20
#     text "Subscription end date :  
#     #{@invoice.end_date.strftime("%d/%m/%Y")}", :size => 13
#   end

#   def subscription_details
#     move_down 40
#     table subscription_item_rows, :width => 500 do
#       row(0).font_style = :bold
#       columns(1..3).align = :right
#       self.header = true
#       self.column_widths = {0 => 200, 1 => 100, 2 => 100, 3 => 100}
#     end
#   end

#   def subscription_amount
#     subscription_amount = @invoice.calculate_subscription_amount
#     vat = @invoice.calculated_vat
#     delivery_charges = @invoice.calculated_delivery_charges
#     sales_tax =  @invoice.calculated_sales_tax
#     table ([["Vat (12.5% of Amount)", "", "", "#{precision(vat)}"] ,
#     ["Sales Tax (10.3% of half the Amount)", "", "",
#     "#{precision(sales_tax)}"]   ,
#     ["Delivery charges", "", "", "#{precision(delivery_charges)}  "],
#     ["", "", "Total Amount", "#{precision(@invoice.total_amount) }  "]]), 
#     :width => 500 do
#       columns(2).align = :left
#       columns(3).align = :right
#       self.header = true
#       self.column_widths = {0 => 200, 1 => 100, 2 => 100, 3 => 100}
#       columns(2).font_style = :bold
#     end
#   end

#   def subscription_item_rows
#     [["Description", "Quantity", "Rate", "Amount"]] +
#     @invoice.subscriptions.map do |subscribe|
#       [ "#{subscribe.description} ", subscribe.quantity, 
#       "#{precision(subscribe.rate)}  ",  
#       "#{precision(subscribe.quantity  * subscribe.rate)}" ]
#     end
#   end

#   def precision(num)
#     @view.number_with_precision(num, :precision => 2)
#   end

#   def regards_message
#     move_down 50
#     text "Thank You," ,:indent_paragraphs => 400
#     move_down 6
#     text "XYZ",
#     :indent_paragraphs => 370, :size => 14, style:  :bold
#   end


end

