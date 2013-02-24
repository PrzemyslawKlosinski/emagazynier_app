class CreateWorkersProductsTable < ActiveRecord::Migration
  def self.up
    create_table :workers_products, :id => false do |t|
        t.references :worker
        t.references :product
    end
    add_index :workers_products, [:worker_id, :product_id]
    add_index :workers_products, [:product_id, :worker_id]
  end

  def self.down
    drop_table :workers_products
  end
end
