# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'themes/index', type: :view do
  before(:each) do
    assign(:themes, [
             Theme.create!(
               name: 'Name',
               image: 'Image',
               position: 2
             ),
             Theme.create!(
               name: 'Name',
               image: 'Image',
               position: 2
             )
           ])
  end

  it 'renders a list of themes' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Image'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
