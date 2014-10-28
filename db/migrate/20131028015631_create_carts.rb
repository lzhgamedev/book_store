class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :book, index: true
      t.references :customer, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
