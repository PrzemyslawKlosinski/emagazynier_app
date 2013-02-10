class AddPrefixToProducts < ActiveRecord::Migration
  def change
    add_column :products, :prefix, :string
  end
end
