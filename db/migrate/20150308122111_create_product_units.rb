# frozen_string_literal: true

class CreateProductUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :product_units do |t|
      t.string :name
      t.string :description
      t.boolean :is_active, default: true

      t.timestamps null: false
    end

    add_index :product_units, :name
  end
end
