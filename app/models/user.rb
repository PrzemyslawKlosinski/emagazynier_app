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
#  isActive                   :boolean          default(FALSE), not null
#  agreementElectronicInvoice :boolean
#  agreementProcessing        :boolean
#  headerPicture              :binary
#  headerText                 :text
#  footerText                 :text
#  location_id                :integer
#  partialInventory           :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  remember_token             :string(255)
#  admin                      :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  belongs_to :location

  #usunie jego produkty gdy usuniemy uzytkownika
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :units, dependent: :destroy
  has_many :firms, dependent: :destroy
  has_many :documents, dependent: :destroy

  has_many :locations, :through => :firms

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
  #For more details on the kind of callbacks supported by Active Record, see the discussion of callbacks at the Rails Guides. (ex before_save)
  #inna metoda zapisania wartosci w before_save
  # before_save { self.email.downcase! }
  before_save { |user| 
  	user.email = email.downcase 
  }
  #inny sposob to zapisywanie cookies w czasie otwartej przeglądarki
  before_save :create_remember_token
  #metoda zapisujaca token
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


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


  #druga opcja na wyslanie maila np po utworzeniu usera (ale przed zapisaniem)
  # after_create :deliver_welcome_email
  # def deliver_welcome_email
  #   UserMailer.welcome_email(self).deliver
  # end

end
