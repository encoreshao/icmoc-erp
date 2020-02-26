# frozen_string_literal: true

class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.string :name
      t.string :appearance
      t.string :image
      t.integer :position

      t.timestamps
    end
  end
end
