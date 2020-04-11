class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :url, index: true, null: false
      t.string :title, index: true, null: false
      t.text :description, null: false
      t.string :mobile_number
      t.string :price, null: false
      t.timestamps
    end
  end
end
