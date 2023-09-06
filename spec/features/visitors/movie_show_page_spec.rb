require "rails_helper"

RSpec.describe "Movie show page" do
  describe "as a visitor" do
    it "gives an error message when trying to create a viewing party" do
      movie1 = Movie.create!(id: 1, title: "Movie Title", rating: 13, description: "This is a description about Movie")

      visit movie_path(movie1)

      click_button "Create Viewing Party"

      expect(current_path).to eq(movie_path(movie1))
      expect(page).to have_content("You must be logged in to create a viewing party!")
    end
  end
end