class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name
      t.string :phone
      t.references :user

      t.timestamps
    end
    add_index :workers, :user_id
  end
end
