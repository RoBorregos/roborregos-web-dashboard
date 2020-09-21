require 'rails_helper'

feature 'User can edit an existing event' do
  before :each do
    @user = create :member
    @event = create :event
    @sponsor = create :sponsor
  end

  scenario 'with complete information' do
    login_as @user
    visit events_path

    find(:css, "a[href='/events/#{@event.id}/edit']").click

    expect(page.current_path).to eq edit_event_path(@event)
    expect(page).to have_content("Editar - #{@event.name}")
    expect(page).to have_button('Guardar')
    expect(page).to have_link('Regresar')


    fill_in 'event_name', with: 'Candidates'
    fill_in 'event_start_date', with: '2020/05/04'
    fill_in 'event_end_date', with: '2020/05/05'
    fill_in 'event_description', with: 'This is a Test.'
    select @sponsor.name, from: 'event_sponsor_id'

    click_button 'Guardar'

    expect(page).to have_content('Candidates')
  end

  scenario 'missing required information' do
    login_as @user
    visit events_path

    find(:css, "a[href='/events/#{@event.id}/edit']").click

    expect(page.current_path).to eq edit_event_path(@event)
    expect(page).to have_content("Editar - #{@event.name}")
    expect(page).to have_button('Guardar')
    expect(page).to have_link('Regresar')


    fill_in 'event_name', with: ''
    fill_in 'event_start_date', with: '2020/05/04'
    fill_in 'event_end_date', with: '2020/05/05'
    fill_in 'event_description', with: 'This is a Test.'
    select @sponsor.name, from: 'event_sponsor_id'

    click_button 'Guardar'

    expect(page).to have_content('Editar -')
  end
end
