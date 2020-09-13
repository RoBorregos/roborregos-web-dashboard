require 'rails_helper'

feature 'User can delete an existing category' do
  before :each do
    @category = create :category
    @user = create :member
  end

  scenario 'and succeeded' do
    login_as @user
    visit categories_path

    expect(page.current_path).to eq categories_path
    expect(page).to have_content('Categorias')
    expect(page).to have_content(@category.name)

    find(:css, "a[data-method='delete']", match: :first).click

    expect(page.current_path).to eq categories_path
    expect(page).to have_content('Categorias')
    expect(page).not_to have_content(@category.name)
  end
end
