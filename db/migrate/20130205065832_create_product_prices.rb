class CreateProductPrices < ActiveRecord::Migration
  def change
    create_table :product_prices do |t|
      t.decimal :nettoPurchasePrice, :default => 0
      t.decimal :bruttoPurchasePrice, :default => 0
      t.decimal :nettoSalesPrice, :default => 0
      t.decimal :bruttoSalesPrice, :default => 0

      t.timestamps
    end
  end
end
