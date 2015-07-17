require "rails_helper"

describe "show/edit user page" do

  let!(:user) { create(:user) }

  context "when user is logged in" do

    before :each do
      login("user@example.com", "password")
    end

    it "shows user edit page" do
      visit edit_profile_path(user)
      expect(page).to have_content "Изменить профиль"
    end

    it "shows user page" do
      visit profile_path(user)
      expect(page).to have_content user.email
    end

  end

  context "when user is not logged" do

    it "doesn't shows the user's page" do
      visit profile_path(user)
      expect(page).to have_content "You have to authenticate to access this page!"
    end

    it "doesn't shows the edit page" do
      visit edit_profile_path(user)
      expect(page).to have_content "You have to authenticate to access this page!"
    end

  end

=begin
  context "when the user is logged in and tries to view/edit page of another user" do

    before :each do
      @user2 = create(:user, email: "user2@example.com")
      login("user@example.com", "password")
    end

    it "restricts access to edit page" do
      visit edit_profile_path(@user2)
      expect(page).to have_content "Access denied!"
    end

    it "restricts access to show page" do
      visit profile_path(@user2)
      expect(page).to have_content "Access denied!"
    end

  end
=end

end
