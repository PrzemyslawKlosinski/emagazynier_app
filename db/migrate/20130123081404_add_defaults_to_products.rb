class AddDefaultsToProducts < ActiveRecord::Migration
  def self.up
    change_column :products, :summaryQuantityPurchase, :decimal, :default => 0
    change_column :products, :summaryQuantitySales, :decimal, :default => 0
    change_column :products, :quantity, :decimal, :default => 0
    change_column :products, :reservedQuantity, :decimal, :default => 0
    change_column :products, :quantityMinimum, :decimal, :default => 0
    change_column :products, :quantityMaximum, :decimal, :default => 0
    change_column :products, :defaultIncrease, :decimal, :default => 0
    change_column :products, :defaultDecrease, :decimal, :default => 0
    change_column :products, :defaultVat, :decimal, :default => 23
  end

  def self.down
    # You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
