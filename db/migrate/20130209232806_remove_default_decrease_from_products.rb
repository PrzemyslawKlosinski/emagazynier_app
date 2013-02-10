class RemoveDefaultDecreaseFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :defaultDecrease
      end

  def down
    add_column :products, :defaultDecrease, :decimal
  end
end
