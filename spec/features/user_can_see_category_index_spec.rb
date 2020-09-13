require 'rails_helper'

feature 'User can see category index' do
  before :each do
    @user = create :member
    @category = create :category
  end

  scenario 'without parameters' do
    login_as @user
    visit categories_path

    expect(page).to have_content('Categorias')
    expect(page).to have_content('Registrar')
    expect(find('.single-category', match: :first)).to have_content(@category.name)
  end

end
