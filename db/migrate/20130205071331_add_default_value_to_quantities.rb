class AddDefaultValueToQuantities < ActiveRecord::Migration
  def change
  	change_column :quantities, :amount, :decimal, :default => 0, :null => false
	change_column :quantities, :netto_price, :decimal, :default => 0
	change_column :quantities, :brutto_price, :decimal, :default => 0
  end

  def self.down
    # You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
