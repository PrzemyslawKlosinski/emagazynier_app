# == Schema Information
#
# Table name: documents
#
#  id                  :integer          not null, primary key
#  is_income           :boolean
#  is_outcome          :boolean
#  is_correct          :boolean
#  status              :integer
#  name                :string(255)
#  title               :string(255)
#  document_date       :datetime
#  brutto_value        :decimal(, )
#  netto_value         :decimal(, )
#  brutto_netto        :decimal(, )
#  description         :text
#  receipt             :string(255)
#  receipt_date        :datetime
#  blocked             :boolean
#  document_correct_id :integer
#  last_correct_id     :integer
#  user_id             :integer
#  firm_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Document < ActiveRecord::Base
  belongs_to :document_correct
  belongs_to :last_correct
  belongs_to :user
  belongs_to :firm


  validates :title, presence: true
  validates :firm, presence: true
  validates :netto_value, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :brutto_value, :numericality => {:greater_than_or_equal_to => 0.01}


  #ustalamy tablice stalych
  DOCTTYPE_VALUES = {
    :PZ => 0,
    :PW => 1,
    :PZK => 2,
    :WZ => 3,
    :RW => 4,
    :WZK => 5
  }
  # TYPES = %w{ mom dad grandmother grandfather son }
  # DOCTTYPE_VALUES.each_with_index do |meth, index|
  #   define_method("#{meth}?") { type == index }
  # end
  # foo_1.status = 'new'
  # foo_1.status -> status: new
  # foo_1.status_id -> status_id: 1

  def doctype
    DOCTTYPE_VALUES[@doctype_id]
  end

  def doctype=(new_value)
    @doctype_id = DOCTTYPE_VALUES.invert[new_value]
    new_value
  end

  attr_reader :doctype_id



  #po wywolaniu konstruktora inicjuje zmienna
  after_initialize :default_values
  private
  def default_values
    self.name ||= "DOC/" + (Document.maximum("id").to_i + 1).to_s
    #parametry sa walidowane w modelu
    self.netto_value ||= 0.0
    self.brutto_value ||= 0.0
    self.brutto_netto ||= 0.0
  end



  #przed zapisaniem do bazy
  # before_save :save_doc_type  
  # def save_doc_type
  # end



  #indywidualna metoda dla paginate
  def self.search_income(is_income, is_outcome, is_correct, search_user, page)
  paginate :per_page => 30, :page => page,
           :conditions => ["is_income = ? and is_outcome = ? and is_correct = ? and user_id = ?", is_income, is_outcome, is_correct, search_user],
           :order => 'name'
  end



  #indywidualna metoda dla paginate
  def self.search(search, search_user, page)
    if !search.blank?
          paginate :per_page => 30, :page => page,
           :conditions => ["title like ? and user_id = ?", "%#{search}%", search_user],
           :order => 'name'
      else
          paginate :per_page => 30, :page => page,
           :conditions => ["user_id = ?", search_user],
           :order => 'name'
      end
  end


# def self.search(search)
#   if search
#     find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
#   else
#     find(:all)
#   end
# end




  #for documents   
  #Glueing the models to each other through a join model
  has_many :quantities
  has_many :products, :through => :quantities

  #Setting up the model’s ability to modify other model attributes
  # http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
  accepts_nested_attributes_for :quantities, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :products

  # Adding the join model attributes to the mass assignment white-list
  #add :quantities_attributes - attr_accessible property contains the properties of the Recipe model itself that can be modified, with the addition of a new property :quantities_attributes.
  attr_accessible :quantities_attributes, :firm_id, :document_correct_id, :blocked, :brutto_netto, :brutto_value, :description, :document_date, :is_correct, :is_income, :is_outcome, :name, :netto_value, :receipt, :receipt_date, :status, :title

end
