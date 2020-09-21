require 'rails_helper'

feature 'User can delete an existing event' do
  before :each do
    @event = create :event
    @user = create :member
  end

  scenario 'and succeeded' do
    login_as @user
    visit events_path

    expect(page.current_path).to eq events_path
    expect(page).to have_content('Eventos')
    expect(page).to have_content(@event.name)

    find(:css, "a[data-method='delete']", match: :first).click

    expect(page.current_path).to eq events_path
    expect(page).to have_content('Eventos')
    expect(page).not_to have_content(@event.name)
  end
end
