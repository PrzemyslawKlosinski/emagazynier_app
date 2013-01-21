# == Schema Information
#
# Table name: products
#
#  id                      :integer          not null, primary key
#  summaryQuantityPurchase :decimal(, )
#  summaryQuantitySales    :decimal(, )
#  nameOryginal            :string(255)
#  name                    :string(255)
#  quantity                :decimal(, )
#  reservedQuantity        :decimal(, )
#  quantityMinimum         :decimal(, )
#  quantityMaximum         :decimal(, )
#  warningNote             :text
#  isWarningShow           :boolean
#  description             :text
#  picture                 :binary
#  blocked                 :boolean
#  user_id                 :integer
#  category_id             :integer
#  productPrice_id         :integer
#  defaultIncrease         :decimal(, )
#  defaultDecrease         :decimal(, )
#  defaultVat              :decimal(, )
#  actualPriceOnPurchase   :boolean
#  manufacturer            :string(255)
#  color                   :string(255)
#  intended                :string(255)
#  location                :string(255)
#  size                    :string(255)
#  shape                   :string(255)
#  descriptions            :text
#  unit_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :productPrice
  belongs_to :unit
  attr_accessible :actualPriceOnPurchase, :blocked, :color, :defaultDecrease, :defaultIncrease, :defaultVat, :description, :descriptions, :intended, :isWarningShow, :location, :manufacturer, :name, :nameOryginal, :picture, :quantity, :quantityMaximum, :quantityMinimum, :reservedQuantity, :shape, :size, :summaryQuantityPurchase, :summaryQuantitySales, :warningNote
end
