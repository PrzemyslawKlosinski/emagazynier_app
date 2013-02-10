# == Schema Information
#
# Table name: products
#
#  id                      :integer          not null, primary key
#  summaryQuantityPurchase :decimal(, )      default(0.0)
#  summaryQuantitySales    :decimal(, )      default(0.0)
#  nameOryginal            :string(255)
#  name                    :string(255)
#  quantity                :decimal(, )      default(0.0)
#  reservedQuantity        :decimal(, )      default(0.0)
#  quantityMinimum         :decimal(, )      default(0.0)
#  quantityMaximum         :decimal(, )      default(0.0)
#  warningNote             :text
#  isWarningShow           :boolean
#  description             :text
#  picture                 :binary
#  blocked                 :boolean
#  user_id                 :integer
#  category_id             :integer
#  productPrice_id         :integer
#  defaultVat              :decimal(, )      default(23.0)
#  actualPriceOnPurchase   :boolean          default(TRUE), not null
#  manufacturer            :string(255)
#  color                   :string(255)
#  intended                :string(255)
#  location                :string(255)
#  size                    :string(255)
#  shape                   :string(255)
#  unit_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  is_public               :boolean          default(FALSE)
#  discount                :integer          default(0)
#

require 'spec_helper'

describe Product do
	let(:user) { FactoryGirl.create(:user) }

	before do
	# This code is wrong!
	# @product = Product.new(name: "Blat czarny", user_id: user.id)
	@product = user.products.build(name: "Blat czarny")
	end

	subject { @product }


	#test czy odpowiada na set /get
	it { should respond_to(:name) }
	it { should respond_to(:user_id) }

	# #test czy jest zmienna user i czy ten produkt ma user_id poprawnie ustawiony
	it { should respond_to(:user) }
	its(:user) { should == user }


	#product powinien byc poprawny jesli user_id != null 
	it { should be_valid }

	#product nie powinien byc poprawny jesli user_id == null
	describe "test user_id jest nieustawiony" do
		before { @product.user_id = nil }
		it { should_not be_valid }
	end

	#niepowinien byc poprawny gdy nie ma nazwy
	describe "with blank name" do
		before { @product.name = " " }
		it { should_not be_valid }
	end
	
	#niepowinien byc poprawny gdy ma nazwe za dluga 
	describe "with name that is too long" do
		before { @product.name = "a" * 141 }
		it { should_not be_valid }
	end

	describe "accessible attributes" do
		#jesli utworzono produkt bez user_id moze to byc luka w programie
		it "should not allow access to user id" do
			expect do
				Product.new(user_id: user.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

end
