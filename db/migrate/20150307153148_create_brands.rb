# frozen_string_literal: true

class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :description
      t.boolean :is_active, default: false

      t.timestamps null: false
    end

    add_index :brands, :name
  end
end
