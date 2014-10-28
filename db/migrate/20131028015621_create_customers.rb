class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :zip
      t.string :address
      t.string :tel

      t.timestamps
    end
  end
end
