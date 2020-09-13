require 'rails_helper'

feature 'User can edit an existing team' do
  before :each do
    @team = create :team
    @user = create :member
    @category = create :category
  end

  scenario 'with complete information' do
    login_as @user
    visit teams_path

    find(:css, "a[href='/teams/#{@team.id}/edit']").click

    expect(page.current_path).to eq edit_team_path(@team)
    expect(page).to have_content("Editar - #{@team.name}")
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

    find(:css, "a[href='/teams/#{@team.id}/edit']").click

    expect(page.current_path).to eq edit_team_path(@team)
    expect(page).to have_content("Editar - #{@team.name}")
    expect(page).to have_button('Guardar')
    expect(page).to have_link('Regresar')

    fill_in 'team_name', with: ''

    click_button 'Guardar'

    expect(page).to have_content("Editar -")
  end
end
