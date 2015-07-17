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
    click_link "Выйти"
    expect(page).to have_content "Войти"
  end

end
