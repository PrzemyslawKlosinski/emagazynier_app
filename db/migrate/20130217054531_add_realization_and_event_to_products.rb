class AddRealizationAndEventToProducts < ActiveRecord::Migration
  def change
    add_column :products, :realization, :integer, :default => 0
    add_column :products, :isEvent, :boolean, :default => false
  end
end
