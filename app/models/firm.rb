class Firm < ActiveRecord::Base
  belongs_to :current_address, :class_name => "Location"
  belongs_to :user

  has_many :locations, dependent: :destroy
  validates :name, presence: true

  attr_accessible :email, :name, :www, :current_address_id
  accepts_nested_attributes_for :current_address
end
