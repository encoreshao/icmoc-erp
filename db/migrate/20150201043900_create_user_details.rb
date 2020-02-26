# frozen_string_literal: true

class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.references :user, index: true
      t.string :name
      t.string :avatar
      t.string :address
      t.string :mobile_phone
      t.string :gender
      t.string :position
      t.string :marriage
      t.string :country
      t.string :birthplace
      t.string :nationality
      t.string :id_card_no
      t.string :locale
      t.string :contact_person
      t.string :contact_phone
      t.date :birthday
      t.integer :age
      t.date :hiredate
      t.references :theme, index: true

      t.timestamps null: false
    end
  end
end
