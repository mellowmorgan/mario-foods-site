class CreateProductsAgain < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :country_of_origin
      t.numeric :cost 
      t.timestamps
    end
  end
end
