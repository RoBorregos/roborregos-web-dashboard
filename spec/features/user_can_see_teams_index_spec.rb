require 'rails_helper'

feature 'User can see team index' do
  before :each do
    @team = create :team
    @user = create :member
  end

  scenario 'without parameters' do
    login_as @user
    visit teams_path

    expect(page).to have_content('Equipos')
    expect(page).to have_content('Registrar')
    expect(find('.single-team', match: :first)).to have_content(@team.name)
  end
end
