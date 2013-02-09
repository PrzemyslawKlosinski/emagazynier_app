# == Schema Information
#
# Table name: product_prices
#
#  id                  :integer          not null, primary key
#  nettoPurchasePrice  :decimal(, )      default(0.0)
#  bruttoPurchasePrice :decimal(, )      default(0.0)
#  nettoSalesPrice     :decimal(, )      default(0.0)
#  bruttoSalesPrice    :decimal(, )      default(0.0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  calculateByPurchase :boolean          default(TRUE), not null
#  product_id          :integer
#

class ProductPrice < ActiveRecord::Base

  belongs_to :product

  attr_accessible :bruttoPurchasePrice, :bruttoSalesPrice, :nettoPurchasePrice, :nettoSalesPrice, :calculateByPurchase, :product
end
