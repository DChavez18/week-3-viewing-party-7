require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  # it 'lists out existing users' do 
  #   user1 = User.create(name: "User One", email: "user1@test.com")
  #   user2 = User.create(name: "User Two", email: "user2@test.com")

  #   expect(page).to have_content('Existing Users:')

  #   within('.existing-users') do 
  #     expect(page).to have_content(user1.email)
  #     expect(page).to have_content(user2.email)
  #   end     
  # end
  # no longer compatible with current user stories
  
  it "has a link for Log In thats takes user to login form" do
    visit '/'
    
    expect(page).to have_link("Log In")

    click_on "Log In"

    expect(current_path).to eq(login_path)
  end
  
  it "logs in the user if user fills in an email and password and takes user to their dashboard" do
    visit '/'
    click_on "Log In"

    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "password123"

    click_button "Log In"

    expect(current_path).to eq(user_path(@user1.id))
    expect(page).to have_content("Welcome!")
  end

  it "does not log in the user if the credential requirements are not met" do
    visit '/'
    click_on "Log In"

    fill_in :email, with: "what!"
    fill_in :password, with: "password123"

    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "displays a link to log out as a logged in user, and no longer shows a link to log in or create and account" do
    visit '/'
    click_on "Log In"

    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "password123"

    click_button "Log In"

    visit '/'

    expect(page).to_not have_link("Log In")
    expect(page).to_not have_button("Create New User")
    expect(page).to have_link("Log Out")
  end

  it "reverts back to having a log in link if the user logs out and sends user back to landing page" do
    visit '/'
    click_on "Log In"

    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "password123"

    click_button "Log In"

    visit '/'

    click_link "Log Out"

    expect(current_path).to eq('/')
    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
  end

  it "the lists of existing users in no longer a link to their show page but just a list of email addresses" do
    visit '/'
    click_on "Log In"

    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "password123"

    click_button "Log In"

    visit '/'

    expect(page).to have_content("Existing Users:")
    expect(page).to_not have_link(@user1.email)
    expect(page).to_not have_link(@user2.email)
    expect(page).to have_content(@user1.email)
    expect(page).to have_content(@user2.email)
  end
end
