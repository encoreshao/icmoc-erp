# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.integer :province_id
      t.integer :city_id
      t.integer :district_id
      t.string :contact_person
      t.string :telephone
      t.string :website
      t.string :fax
      t.string :postcode
      t.string :logo
      t.string :industry
      t.string :nature_of_business
      t.text :introduction
      t.text :description
      t.string :tax_no
      t.string :legal_person
      t.string :bank_address
      t.string :bank_account

      t.timestamps null: false
    end

    add_index :companies, :name
    add_index :companies, :province_id
    add_index :companies, :city_id
    add_index :companies, :district_id
  end
end
