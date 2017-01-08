require "rails_helper"

describe "the register proccess" do

  it "registers an user when data are correct" do
    register("user@example.com", "password", "password")
    expect(page).to have_content "Мои колоды"
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
