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

# !!! UWAGA DAJEMY attr_accessible: category_id

class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :productPrice
  belongs_to :unit

  #for documents
  has_many :quantities
  has_many :documents, through: :quantities

   # constants
  MYUNITS = {
    :kilogram => 0,
    :centymetr => 1,
  }
  # TYPES = %w{ mom dad grandmother grandfather son }
  # TYPES.each_with_index do |meth, index|
  #   define_method("#{meth}?") { type == index }
  # end

  # validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 40 }

  #pozwala wyswietlac produkty w odwrotnej kolejnosci
  default_scope order: 'products.created_at DESC'

  attr_accessible :category_id, :unit_id, :actualPriceOnPurchase, :blocked, :color, :defaultDecrease, :defaultIncrease, :defaultVat, :description, :descriptions, :intended, :isWarningShow, :location, :manufacturer, :name, :nameOryginal, :picture, :quantity, :quantityMaximum, :quantityMinimum, :reservedQuantity, :shape, :size, :summaryQuantityPurchase, :summaryQuantitySales, :warningNote
end
