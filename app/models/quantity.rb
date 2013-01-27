class Quantity < ActiveRecord::Base

  #Creating the join relationship
  belongs_to :document
  belongs_to :product

  #for documents
  #allow the join model to modify its relational model
  accepts_nested_attributes_for :product, :reject_if => :all_blank

  # Adding the join model attributes to the …join model attribute white-list
  attr_accessible :amount, :product, :product_attributes, :brutto_price, :netto_price

end
