class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :shortName
      t.boolean :isDefault
      t.references :user

      t.timestamps
    end
    add_index :units, :user_id
  end
end
