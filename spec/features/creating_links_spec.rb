require 'spec_helper'


feature 'Creating links' do

  scenario 'I can create a new link' do
    visit '/links/new'
    expect(page).to have_content('hi')
    # fill_in 'url',  with: 'https://www.zombo.com/'
    # fill_in 'title', with: 'This is Zombocom'
    # click_button 'Create link'

    #   # we expect to be redirected back to the links page
    #   expect(current_path).to eq '/links'

    #   within 'ul#links' do
    #   	expect(page).to have_content('This is Zombocom')
  end
end