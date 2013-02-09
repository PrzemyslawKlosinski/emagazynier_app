class AddDefaultValueToProducts < ActiveRecord::Migration
  def self.up
	change_column :products, :actualPriceOnPurchase, :boolean, :null => false, :default => true
  end
end
