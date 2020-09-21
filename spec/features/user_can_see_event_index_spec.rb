require 'rails_helper'

feature 'User can see event index' do
  before :each do
    @user = create :member
    @event = create :event
  end

  scenario 'without parameters' do
    login_as @user
    visit events_path

    expect(page).to have_content('Eventos')
    expect(page).to have_content('Registrar')
    expect(find('.single-event', match: :first)).to have_content(@event.name)
  end

end
