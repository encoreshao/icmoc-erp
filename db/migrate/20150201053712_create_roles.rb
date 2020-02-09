# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :position
      t.boolean :assignable
      t.integer :builtin, default: 0, null: false
      t.text :permissions

      t.timestamps null: false
    end

    add_index :roles, :name
  end
end
