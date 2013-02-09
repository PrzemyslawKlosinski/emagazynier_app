class AddUnsoldToQuantities < ActiveRecord::Migration
  def change
    add_column :quantities, :unsold, :decimal, :default => 0, :null => false
  end
end
