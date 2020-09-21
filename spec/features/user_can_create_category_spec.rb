require 'rails_helper'

feature 'User can create a new category' do
  before :each do
    @user = create :member
  end

  scenario 'with complete information' do
    login_as @user
    visit categories_path

    click_link 'Registrar'

    expect(page.current_path).to eq new_category_path
    expect(page).to have_content('Nueva Categoria')
    expect(page).to have_button('Guardar')
    expect(page).to have_link('Regresar')

    fill_in 'category_name', with: 'Junior'
    fill_in 'category_description', with: 'This is is a Junir Category'
    fill_in 'category_reference_url', with: 'github.com'

    click_button 'Guardar'

    expect(page).to have_content('Junior')
  end

  scenario 'missing required information' do
    login_as @user
    visit categories_path

    click_link 'Registrar'

    expect(page.current_path).to eq new_category_path
    expect(page).to have_content('Nueva Categoria')
    expect(page).to have_button('Guardar')
    expect(page).to have_link('Regresar')

    fill_in 'category_name', with: ''
    fill_in 'category_description', with: 'This is is a Junir Category'
    fill_in 'category_reference_url', with: 'github.com'

    click_button 'Guardar'

    expect(page).to have_content('Nueva Categoria')
  end
end
