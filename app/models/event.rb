# encoding: utf-8
# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  start_at    :datetime
#  end_at      :datetime
#  all_day     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  worker_id   :integer
#  product_id  :integer
#  customer    :string(255)
#  email       :string(255)
#  description :text
#  amount      :decimal(, )      default(0.0)
#


class Event < ActiveRecord::Base
  has_event_calendar

  #for event
  belongs_to :worker
  belongs_to :product

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }
  validates :customer, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  # validates :worker, presence: true
  validates :start_at, presence: true
  # validates :amount, presence: true

  validate :date_is_occupied
  validate :higher_then_amount

# "created_at" BETWEEN '2010-09-29' AND '2010-11-30
  def date_is_occupied 
    events = Event.where("worker_id = ?", self.worker_id).where("(start_at BETWEEN '#{self.start_at}' AND '#{self.end_at}' ) OR (end_at BETWEEN '#{self.start_at}' AND '#{self.end_at}')")
    if !events.empty?
      errors.add(:start_at, "Ten termin jest już zajęty.")
    end
  end

  #check is lower then 20 amount
  def higher_then_amount
      if self.amount > 20
        errors.add(:amount, "Zakup jednorazowy ograniczono do 20.") 
      end
  end

  #indywidualna metoda search dla paginate
  def self.search(search, page)
    if !search.blank?
          paginate :per_page => 30, :page => page,
           :conditions => ["email like ?", "%#{search}%"],
           :order => 'start_at'
      else
          paginate :per_page => 30, :page => page,
           :order => 'start_at'
      end
  end


  attr_accessible :name, :start_at, :end_at, :all_day, :worker_id, :product_id, :customer, :email, :amount, :description
end
