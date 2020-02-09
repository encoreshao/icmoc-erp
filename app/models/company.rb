# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                 :integer          not null, primary key
#  name               :string
#  address            :string
#  country            :string
#  city               :string
#  contact_person     :string
#  telephone          :string
#  website            :string
#  fax                :string
#  postcode           :string
#  logo               :string
#  description        :text
#  industry           :string
#  nature_of_business :string
#  introduction       :text
#  tax_no             :string
#  legal_person       :string
#  bank_address       :string
#  bank_account       :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Company < ApplicationRecord
  mount_uploader :logo, CompanyLogoUploader

  validates :name, presence: true, uniqueness: true

  after_commit :remove_logo!, on: :destroy

  def self.customers
    select('id, name').map { |e| [e.name, e.id] }
  end
end
