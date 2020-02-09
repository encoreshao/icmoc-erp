# frozen_string_literal: true

class CreateReimbursements < ActiveRecord::Migration[5.2]
  def change
    create_table :reimbursements do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.string :state
      t.integer :episodes_count

      t.timestamps null: false
    end
  end
end
