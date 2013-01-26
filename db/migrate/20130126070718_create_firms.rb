class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string :name
      t.string :www
      t.string :email
      t.references :current_address
      t.references :user

      t.timestamps
    end
    add_index :firms, :current_address_id
    add_index :firms, :user_id
  end
end
