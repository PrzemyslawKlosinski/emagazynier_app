# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string(255)
#  password_digest            :string(255)
#  name                       :string(255)
#  about                      :text
#  www                        :string(255)
#  isActive                   :boolean
#  agreementElectronicInvoice :boolean
#  agreementProcessing        :boolean
#  headerPicture              :binary
#  headerText                 :text
#  footerText                 :text
#  location_id                :integer
#  partialInventory           :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class User < ActiveRecord::Base
  belongs_to :location
  attr_accessible :about, :agreementElectronicInvoice, :agreementProcessing, :email, :footerText, :headerPicture, :headerText, :isActive, :name, :partialInventory, :password_digest, :www, :password, :password_confirmation


  #gem bcrypt-ruby
  has_secure_password


  #przykladowy konstruktor
  # def initialize(attributes = {})		#dzieki inicjowaniu konstruktora z parametrem hashmapy, mozemy uzyc konstruktora jak ponizej
  # 	@name = attributes[:name]
  # 	@email = attributes[:email]
  # end


  #po wywolaniu konstruktora inicjuje zmienna
  after_initialize :default_values
  private
  def default_values
  	self.name ||= genName()
  	# self.isActive ||= false
  end


  #metoda wywolywana przed zapisaniem obiektu do bazy
  before_save { |user| 
  	user.email = email.downcase 
  }
  #inna metoda zapisania wartosci w before_save
  # before_save { self.email.downcase! }


  #walidacja pol
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
  # validates :password_confirmation, presence: true


  #metoda pomocnicza generujaca kolejna nazwe
  def genName()
  	baseName = "EMAGAZYNIER"
  	user = User.find(:last)
  	if(user.nil?)
  		return "#{baseName}1"
  	else
  		return "#{baseName}#{user.id+1}"
  	end
  end

end
