# encoding: utf-8
# == Schema Information
#
# Table name: quantities
#
#  id                 :integer          not null, primary key
#  amount             :decimal(, )      default(0.0), not null
#  netto_price        :decimal(, )      default(0.0)
#  brutto_price       :decimal(, )      default(0.0)
#  product_id         :integer
#  document_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  discount           :integer          default(0)
#  unsold             :decimal(, )      default(0.0), not null
#  netto_sales_price  :decimal(, )      default(0.0)
#  brutto_sales_price :decimal(, )      default(0.0)
#

class Quantity < ActiveRecord::Base

  #Creating the join relationship
  belongs_to :document
  belongs_to :product

  # before_validation :moja_metoda

  validates :amount, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :product_id, presence: true
  validates :netto_price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :brutto_price, :numericality => {:greater_than_or_equal_to => 0.01}
  # validates :brutto_price, :numericality => {:greater_than_or_equal_to => 0.01}
  
  #validator nie pozwala sprzedac wiecej niz na stanie
  validate :sold_more_than_have
  


  #for documents
  #allow the join model to modify its relational model
  accepts_nested_attributes_for :product, :reject_if => :all_blank

  # Adding the join model attributes to the …join model attribute white-list
  attr_accessible :amount, :product_id, :product_attributes, :brutto_price, :netto_price, :discount, :unsold, :netto_sales_price, :brutto_sales_price

# private
def sold_more_than_have
  #jesli quantity dotyczy dokumentu sprzedazy
  product = Product.find(product_id)
  if self.unsold == -1
    #jesli product quantity mniejsze niz amount
    if product.quantity < self.amount
      errors.add(:amount, "Brak towaru w magazynie.")
    end
  end
end


end
