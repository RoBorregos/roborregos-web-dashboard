require 'rails_helper'

feature 'User can create a new team' do
  before :each do
    @user = create :member
    @category = create :category
  end

  scenario 'with complete information' do
    login_as @user
    visit teams_path

    click_link 'Registrar'

    expect(page.current_path).to eq new_team_path
    expect(page).to have_content('Nuevo Equipo')
    expect(page).to have_button('Guardar')
    expect(page).to have_link('Regresar')

    fill_in 'team_name', with: 'Soccer Open'
    fill_in 'team_github_url', with: 'https://github.com/RoBorregos/RoboCup_SoccerOpen_2020'
    select @category.name , from: 'team_category_id'
    click_button 'Guardar'

    expect(page).to have_content('Soccer Open')
  end

  scenario 'missing required information' do
    login_as @user
    visit teams_path

    click_link 'Registrar'

    expect(page.current_path).to eq new_team_path
    expect(page).to have_content('Nuevo Equipo')
    expect(page).to have_button('Guardar')
    expect(page).to have_link('Regresar')

    fill_in 'team_name', with: ''
    select @category.name , from: 'team_category_id'
    click_button 'Guardar'

    expect(page).to have_content('Nuevo Equipo')
  end
end
