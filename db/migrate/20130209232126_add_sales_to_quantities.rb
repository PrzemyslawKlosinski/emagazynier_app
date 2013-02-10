class AddSalesToQuantities < ActiveRecord::Migration
  def change
    add_column :quantities, :netto_sales_price, :decimal, :default => 0
    add_column :quantities, :brutto_sales_price, :decimal, :default => 0
  end
end
