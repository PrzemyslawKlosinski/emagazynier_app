# encoding: utf-8
# == Schema Information
#
# Table name: workers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Worker < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :products

  has_many :events

  attr_accessible :name, :phone
end
