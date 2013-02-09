class AddDiscountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :discount, :integer, :default => 0
  end
end
