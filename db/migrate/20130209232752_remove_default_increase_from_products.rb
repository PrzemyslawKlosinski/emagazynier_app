class RemoveDefaultIncreaseFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :defaultIncrease
      end

  def down
    add_column :products, :defaultIncrease, :decimal
  end
end
