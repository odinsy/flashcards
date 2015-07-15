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
