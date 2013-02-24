class AddWorkerAndProductToEvents < ActiveRecord::Migration
  def change
    add_column :events, :worker_id, :integer
    add_column :events, :product_id, :integer
  end
end
