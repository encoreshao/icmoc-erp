# frozen_string_literal: true

# == Schema Information
#
# Table name: sales
#
#  id                 :integer          not null, primary key
#  company_id         :integer
#  contact_no         :string
#  name               :string
#  payment_mode       :string
#  money              :float
#  freight_charge     :float
#  tax                :string
#  type_name          :string
#  state              :string
#  order_type         :string
#  order_no           :string
#  delivery_time      :date
#  delivery_place     :string
#  delivery_content   :text
#  number             :integer
#  unit               :string
#  description        :text
#  owner_id           :integer
#  created_by         :integer
#  created_date       :datetime
#  last_modified_by   :integer
#  last_modified_date :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Sale < ActiveRecord::Base
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
