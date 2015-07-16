require "rails_helper"

describe "the login/logout proccess" do

  let!(:user) { create(:user) }

  it "signs me in when user data are correct" do
    login("user@example.com", "password")
    expect(page).to have_content "Login successful"
  end

  it "fails when user data are wrong" do
    login("user@example.com", "123")
    expect(page).to have_content "Login failed"
  end

  it "sings me out" do
    login("user@example.com", "password")
    click_link "Log Out"
    expect(page).to have_content "Войти"
  end

end

describe "the register proccess" do

  it "registers an user when data are correct" do
    register("user@example.com", "password", "password")
    expect(page).to have_content "Мои карточки"
  end

  it "doesn't registers when user exists" do
    @user = create(:user)
    register("user@example.com", "password", "password")
    expect(page).to have_content "has already been taken"
  end

  it "doesn't registers when password and password confirmation are different" do
    register("user@example.com", "password", "pass")
    expect(page).to have_content "doesn't match Password"
  end

end

describe "show/edit user page" do

  before :each do
    @user = create(:user)
  end

  it "doesn't shows the user's page when an user not logged in" do
    visit user_path(@user)
    expect(page).to have_content "You have to authenticate to access this page!"
  end

  it "doesn't shows the edit page when an user not logged in" do
    visit edit_user_path(@user)
    expect(page).to have_content "You have to authenticate to access this page!"
  end

  it "shows the edit page when the user is logged" do
    login("user@example.com", "password")
    visit edit_user_path(@user)
    expect(page).to have_content "Редактировать профиль"
  end

  it "shows the user's page when the user is logged" do
    login("user@example.com", "password")
    visit user_path(@user)
    expect(page).to have_content @user.email
  end

  it "restricts access when user trying to edit page of another user" do
    @user2 = create(:user, email: "user2@example.com")
    login("user@example.com", "password")
    visit edit_user_path(@user2)
    expect(page).to have_content "Access denied!"
  end

  it "restricts access when user trying to show page of another user" do
    @user2 = create(:user, email: "user2@example.com")
    login("user@example.com", "password")
    visit user_path(@user2)
    expect(page).to have_content "Access denied!"
  end

end
