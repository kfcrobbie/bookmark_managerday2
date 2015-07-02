require 'spec_helper'

feature 'User sign up' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.


  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'With an email that is already registered' do
    sign_up
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('Sorry, there were the following problems with the form.')
  end

  scenario 'With a password that does not match' do
    user = create(:user, password_confirmation: 'wrong') #This creates a user as per factory girl settings, but with password conf set to wrong
    visit '/users/new'
    fill_in_forms(user)
    expect { click_button 'Sign up' }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content('Sorry, your passwords do not match')
  end

  def sign_up
    user = build :user
    visit '/users/new'
    fill_in_forms(user)
    click_button 'Sign up'
  end

  def fill_in_forms (user)
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation

  end
end