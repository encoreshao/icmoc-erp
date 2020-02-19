# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                 :bigint           not null, primary key
#  address            :string
#  bank_account       :string
#  bank_address       :string
#  contact_email      :string
#  contact_person     :string
#  description        :text
#  fax                :string
#  industry           :string
#  legal_person       :string
#  logo               :string
#  name               :string
#  nature_of_business :string
#  overview           :text
#  postcode           :string
#  tax_no             :string
#  telephone          :string
#  website            :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  city_id            :integer
#  district_id        :integer
#  province_id        :integer
#
# Indexes
#
#  index_companies_on_city_id      (city_id)
#  index_companies_on_district_id  (district_id)
#  index_companies_on_name         (name)
#  index_companies_on_province_id  (province_id)
#

class Company < ApplicationRecord
  mount_uploader :logo, CompanyLogoUploader

  validates :name, presence: true, uniqueness: true

  # Regions
  belongs_to :province, optional: true
  belongs_to :city, optional: true
  belongs_to :district, optional: true

  # Delegate for region name
  delegate :name, to: :province, allow_nil: true, prefix: true
  delegate :name, to: :city, allow_nil: true, prefix: true
  delegate :name, to: :district, allow_nil: true, prefix: true

  after_commit :remove_logo!, on: :destroy

  def self.customers
    select('id, name').map { |e| [e.name, e.id] }
  end
end
