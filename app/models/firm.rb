class Firm < ActiveRecord::Base
  belongs_to :current_address
  belongs_to :user

  has_many :locations, dependent: :destroy
  validates :name, presence: true

  attr_accessible :email, :name, :www
end
