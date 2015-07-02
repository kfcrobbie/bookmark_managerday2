require 'spec_helper'

feature 'User sign up' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.

  before(:each) { @user = User.new(user_attributes)}

  scenario 'I can sign up as a new user' do
    expect { sign_up(@user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'With an email that is already registered' do
    sign_up
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('Sorry, there were the following problems with the form.')
  end

  scenario 'With a password that does not match' do

