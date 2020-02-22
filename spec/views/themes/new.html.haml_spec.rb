# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'themes/new', type: :view do
  before(:each) do
    assign(:theme, Theme.new(
                     name: 'MyString',
                     image: 'MyString',
                     position: 1
                   ))
  end

  it 'renders new theme form' do
    render

    assert_select 'form[action=?][method=?]', themes_path, 'post' do
      assert_select 'input[name=?]', 'theme[name]'

      assert_select 'input[name=?]', 'theme[image]'

      assert_select 'input[name=?]', 'theme[position]'
    end
  end
end
