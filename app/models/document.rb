class Document < ActiveRecord::Base
  belongs_to :document_correct
  belongs_to :last_correct
  belongs_to :user
  belongs_to :firm


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
  attr_accessible :quantities_attributes, :blocked, :brutto_netto, :brutto_value, :description, :document_date, :is_correct, :is_income, :is_outcome, :name, :netto_value, :receipt, :receipt_date, :status, :title

end
