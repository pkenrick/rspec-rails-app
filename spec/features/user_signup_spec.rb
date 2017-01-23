require 'rails_helper'

feature "User signup" do

  scenario 'allows a valid user to be signed up' do
    signup
    expect(page).to have_content("John, john@email.com")
  end

  scenario 'describes error above form when wrong information submitted' do
    signup(email: "john@email", first_name: "J", password: "", password_confirmation: "")
    expect(page).to have_content("Sign up")

    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("First name is too short (minimum is 2 characters)")
    expect(page).to have_content("Password can't be blank")
  end

end
