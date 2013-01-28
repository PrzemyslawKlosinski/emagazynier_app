# == Schema Information
#
# Table name: firms
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  www                :string(255)
#  email              :string(255)
#  current_address_id :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Firm < ActiveRecord::Base
  belongs_to :current_address, :class_name => "Location"
  belongs_to :user

  has_many :locations, dependent: :destroy
  validates :name, presence: true

  attr_accessible :email, :name, :www, :current_address_id
  accepts_nested_attributes_for :current_address
end
