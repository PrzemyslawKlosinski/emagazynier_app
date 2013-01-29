# == Schema Information
#
# Table name: quantities
#
#  id           :integer          not null, primary key
#  amount       :decimal(, )
#  netto_price  :decimal(, )
#  brutto_price :decimal(, )
#  product_id   :integer
#  document_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Quantity < ActiveRecord::Base

  #Creating the join relationship
  belongs_to :document
  belongs_to :product

  validates :amount, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :product_id, presence: true
  validates :netto_price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :brutto_price, :numericality => {:greater_than_or_equal_to => 0.01}
  # validates :brutto_price, :numericality => {:greater_than_or_equal_to => 0.01}

  #for documents
  #allow the join model to modify its relational model
  accepts_nested_attributes_for :product, :reject_if => :all_blank

  # Adding the join model attributes to the …join model attribute white-list
  attr_accessible :amount, :product_id, :product_attributes, :brutto_price, :netto_price

end
