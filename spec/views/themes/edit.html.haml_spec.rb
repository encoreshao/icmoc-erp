# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'themes/edit', type: :view do
  before(:each) do
    @theme = assign(:theme, Theme.create!(
                              name: 'MyString',
                              image: 'MyString',
                              position: 1
                            ))
  end

  it 'renders the edit theme form' do
    render

    assert_select 'form[action=?][method=?]', theme_path(@theme), 'post' do
      assert_select 'input[name=?]', 'theme[name]'

      assert_select 'input[name=?]', 'theme[image]'

      assert_select 'input[name=?]', 'theme[position]'
    end
  end
end
