class AddTimestampsToProducts < ActiveRecord::Migration[5.2]
  def change_table
    add_column :products, :created_at, :datetime, null: false
    add_column :products, :updated_at, :datetime, null: false
  end
end
