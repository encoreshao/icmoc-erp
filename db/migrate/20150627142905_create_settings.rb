# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :depot_alarm_value
      t.string :project_payment_mode
      t.string :purchase_payment_mode
      t.integer :created_by
      t.datetime :created_date
      t.integer :last_modified_by
      t.datetime :last_modified_date

      t.timestamps null: false
    end
  end
end
