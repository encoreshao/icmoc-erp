# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id                 :bigint           not null, primary key
#  contact_no         :string
#  created_by         :integer
#  created_date       :datetime
#  delivery_content   :text
#  delivery_place     :string
#  delivery_time      :date
#  description        :text
#  freight_charge     :float
#  last_modified_by   :integer
#  last_modified_date :datetime
#  money              :float
#  name               :string
#  number             :integer
#  order_no           :string
#  order_type         :string
#  payment_mode       :string
#  state              :string
#  tax                :string
#  type_name          :string
#  unit               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :integer
#  owner_id           :integer
#
# Indexes
#
#  index_sales_on_company_id  (company_id)
#  index_sales_on_contact_no  (contact_no)
#  index_sales_on_order_no    (order_no)
#  index_sales_on_owner_id    (owner_id)
#

class Sale < ApplicationRecord
  extend Enumerize

  validates :name, :owner_id, :type_name, :company_id, :state, presence: true
  belongs_to :owner, class_name: 'User', primary_key: 'id', foreign_key: 'owner_id'
  belongs_to :company

  enumerize :state, in: %i[process closed], scopes: true, methods: true, default: :process
  enumerize :order_type, in: %i[normals delays], scopes: true, methods: true, default: :normals
  enumerize :type_name, in: %i[commerces projects], scopes: true, methods: true

  before_save :setup_base_options
  after_create do |sale|
    a = Project.new(name: sale.name, sale_id: sale.id, number: sale.order_no)
    puts a.errors.full_messages unless a.save
  end

  private

  def setup_base_options
    time = Time.now

    order_no = if type_name == :commerces
                 "C-#{time.year}#{time.to_i}"
               else
                 "P-#{time.year}#{time.to_i}"
               end

    created_date = time
  end
end
