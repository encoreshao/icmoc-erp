# frozen_string_literal: true

class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :name
      t.string :avatar
      t.string :address
      t.string :mobile_phone
      t.string :gender
      t.string :position
      t.integer :age
      t.date :birthday
      t.string :marriage
      t.date :hiredate
      t.string :country
      t.string :birthplace
      t.string :nationality
      t.string :id_card_no
      t.references :user, index: true

      t.string :contact_person
      t.string :contact_phone

      t.timestamps null: false
    end
  end
end
