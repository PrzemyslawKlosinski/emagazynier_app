# encoding: utf-8

# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  zip_code   :string(255)
#  city       :string(255)
#  address    :string(255)
#  phone      :string(255)
#  firm_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  belongs_to :firm

  validates :city, presence: { message: "nie może być puste" }
  validates :address, presence: true

  attr_accessible :address, :city, :phone, :zip_code
end
