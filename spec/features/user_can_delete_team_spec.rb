require 'rails_helper'

feature 'User can delete an existing team' do
  before :each do
    @team_to_delete = create :team
    @user = create :member
  end

  scenario 'and succeeded' do
    login_as @user
    visit teams_path

    expect(page.current_path).to eq teams_path
    expect(page).to have_content('Equipos')
    expect(page).to have_content(@team_to_delete.name)

    find(:css, "a[data-method='delete']", match: :first).click

    expect(page.current_path).to eq teams_path
    expect(page).to have_content('Equipos')
    expect(page).not_to have_content(@team_to_delete.name)
  end
end
