require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe "As a visitor" do
    before :each do 
      @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
      @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")
    end
  
    it "does not show the section of that page that lists exisiting users" do
      visit '/'

      expect(page).to_not have_content("Existing Users:")
      expect(page).to_not have_content(@user1.email)
      expect(page).to_not have_content(@user2.email)
    end

    it "does not allow me to visit '/dashboard' and I remain on the landing page and I see an error message" do
      visit '/'

      expect(current_path).to eq('/')

      visit '/dashboard'

      expect(current_path).to eq('/')
      expect(page).to have_content("You MUST be logged in or registered to access!")
    end
  end
end