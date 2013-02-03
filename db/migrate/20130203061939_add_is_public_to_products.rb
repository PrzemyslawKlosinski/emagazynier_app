class AddIsPublicToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_public, :boolean, default: false
  end
end
