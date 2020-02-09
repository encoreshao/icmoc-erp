# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :company_id
      t.string :contact_no
      t.string :name
      t.string :payment_mode
      t.float :money
      t.float :freight_charge
      t.string :tax
      t.string :type_name
      t.string :state
      t.string :order_type
      t.string :order_no
      t.date :delivery_time
      t.string :delivery_place
      t.text :delivery_content
      t.integer :number
      t.string :unit
      t.text :description
      t.integer :owner_id
      t.integer :created_by
      t.datetime :created_date
      t.integer :last_modified_by
      t.datetime :last_modified_date

      t.timestamps null: false
    end

    add_index :sales, :company_id
    add_index :sales, :owner_id
    add_index :sales, :contact_no
    add_index :sales, :order_no
  end
end
