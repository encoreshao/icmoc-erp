# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :model
      t.references :brand, index: true
      t.references :product_unit, index: true
      t.boolean :is_active, default: false

      t.timestamps null: false
    end

    add_index :products, :name
  end
end
