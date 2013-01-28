# == Schema Information
#
# Table name: products
#
#  id                      :integer          not null, primary key
#  summaryQuantityPurchase :decimal(, )      default(0.0)
#  summaryQuantitySales    :decimal(, )      default(0.0)
#  nameOryginal            :string(255)
#  name                    :string(255)
#  quantity                :decimal(, )      default(0.0)
#  reservedQuantity        :decimal(, )      default(0.0)
#  quantityMinimum         :decimal(, )      default(0.0)
#  quantityMaximum         :decimal(, )      default(0.0)
#  warningNote             :text
#  isWarningShow           :boolean
#  description             :text
#  picture                 :binary
#  blocked                 :boolean
#  user_id                 :integer
#  category_id             :integer
#  productPrice_id         :integer
#  defaultIncrease         :decimal(, )      default(0.0)
#  defaultDecrease         :decimal(, )      default(0.0)
#  defaultVat              :decimal(, )      default(23.0)
#  actualPriceOnPurchase   :boolean
#  manufacturer            :string(255)
#  color                   :string(255)
#  intended                :string(255)
#  location                :string(255)
#  size                    :string(255)
#  shape                   :string(255)
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

  # validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 40 }

  #pozwala wyswietlac produkty w odwrotnej kolejnosci
  default_scope order: 'products.created_at DESC'

  #indywidualna metoda search dla paginate
  def self.search(search, search_user, page)
    if !search.blank?
          paginate :per_page => 30, :page => page,
           :conditions => ["name like ? and user_id = ?", "%#{search}%", search_user],
           :order => 'name'
      else
          paginate :per_page => 30, :page => page,
           :conditions => ["user_id = ?", search_user],
           :order => 'name'
      end
  end

  attr_accessible :category_id, :unit_id, :actualPriceOnPurchase, :blocked, :color, :defaultDecrease, :defaultIncrease, :defaultVat, :description, :descriptions, :intended, :isWarningShow, :location, :manufacturer, :name, :nameOryginal, :picture, :quantity, :quantityMaximum, :quantityMinimum, :reservedQuantity, :shape, :size, :summaryQuantityPurchase, :summaryQuantitySales, :warningNote
end
