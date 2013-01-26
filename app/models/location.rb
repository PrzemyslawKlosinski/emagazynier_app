class Location < ActiveRecord::Base
  belongs_to :firm

  validates :city, presence: true
  validates :address, presence: true

  attr_accessible :address, :city, :phone, :zip_code
end
