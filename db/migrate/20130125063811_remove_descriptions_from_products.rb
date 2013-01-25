class RemoveDescriptionsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :descriptions
      end

  def down
    add_column :products, :descriptions, :text
  end
end
