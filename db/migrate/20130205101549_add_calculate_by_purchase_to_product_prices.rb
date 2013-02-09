class AddCalculateByPurchaseToProductPrices < ActiveRecord::Migration
  def change
    add_column :product_prices, :calculateByPurchase, :boolean, :null => false, :default => true
  end
end
