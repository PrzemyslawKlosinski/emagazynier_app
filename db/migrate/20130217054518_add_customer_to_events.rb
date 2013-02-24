class AddCustomerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :customer, :string
    add_column :events, :email, :string
    add_column :events, :description, :text
    add_column :events, :amount, :decimal, :default => 0
  end
end
