def login(email, password)
  visit root_path
  click_link "Войти"
  fill_in :session_email, with: email
  fill_in :session_password, with: password
  click_button "Login"
end
