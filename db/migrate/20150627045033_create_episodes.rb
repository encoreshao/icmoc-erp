# frozen_string_literal: true

class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.references :reimbursement, index: true
      t.date :activity_date
      t.string :usage
      t.float :amount
      t.text :description
      t.integer :count

      t.timestamps null: false
    end
  end
end
