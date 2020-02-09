# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :number
      t.integer :pm_user_id
      t.float :budget
      t.references :sale, index: true
      t.boolean :is_closed

      t.timestamps null: false
    end

    add_index :projects, :name
    add_index :projects, :number
    add_index :projects, :pm_user_id
  end
end
