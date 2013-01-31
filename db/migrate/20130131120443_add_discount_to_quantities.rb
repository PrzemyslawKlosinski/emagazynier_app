class AddDiscountToQuantities < ActiveRecord::Migration
  def change
    add_column :quantities, :discount, :integer, :default => 0
  end
end
