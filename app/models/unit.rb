# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  shortName  :string(255)
#  isDefault  :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Unit < ActiveRecord::Base
  belongs_to :user
  has_many :products

  validates :user_id, presence: true
  validates :name, presence: true
  validates :name, :uniqueness => true
  validates :shortName, presence: true
  validates :shortName, :uniqueness => true

  attr_accessible :isDefault, :name, :shortName
end
