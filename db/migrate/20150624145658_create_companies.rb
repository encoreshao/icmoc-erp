# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.integer :province_id
      t.integer :city_id
      t.integer :district_id
      t.string :address
      t.string :contact_person
      t.string :contact_email
      t.string :telephone
      t.string :website
      t.string :fax
      t.string :postcode
      t.string :industry
      t.string :nature_of_business
      t.string :tax_no
      t.string :legal_person
      t.string :bank_address
      t.string :bank_account
      t.text :overview
      t.text :description

      t.timestamps null: false
    end

    add_index :companies, :name
    add_index :companies, :province_id
    add_index :companies, :city_id
    add_index :companies, :district_id
  end
end
