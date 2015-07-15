def register(email, password, password_confirmation)
  visit sign_up_path
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password_confirmation
  click_button "Create User"
end
