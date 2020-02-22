# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'themes/show', type: :view do
  before(:each) do
    @theme = assign(:theme, Theme.create!(
                              name: 'Name',
                              image: 'Image',
                              position: 2
                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/2/)
  end
end
