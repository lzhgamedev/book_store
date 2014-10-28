class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.integer :price
      t.references :category, index: true
      t.string :icon_path
      t.string :picture_path
      t.text :description
      t.integer :display_order

      t.timestamps
    end
  end
end
