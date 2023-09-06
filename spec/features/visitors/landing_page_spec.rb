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
  end
end