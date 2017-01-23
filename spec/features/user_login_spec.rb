require 'rails_helper'

feature 'User login' do

  let!(:user) do
    User.create(email: "john@email.com", first_name: "John", last_name: "Smith", age: 21, password: "helloo", password_confirmation: "helloo")
  end

  scenario 'allows a valid user to be logged in' do
    login
    expect(page).to have_content("Welcome.  You have been logged in!")
    expect(page).to have_content("John, john@email.com")
  end

  scenario 'disallows an invalid email user to be logged in, displaying error message above form' do
    login(email: "bill@email.com")
    expect(page).to have_content("Sorry.  Your email or password were invalid.")
    expect(page).to have_content("Log in")
  end

  scenario 'disallows an invalid password user to be logged in, displaying error message above form' do
    login(password: "incorrectpassword")
    expect(page).to have_content("Sorry.  Your email or password were invalid.")
    expect(page).to have_content("Log in")
  end

  scenario 'should remove the login button from view once signed in' do
    login
    expect(page).not_to have_content("Log in")
    expect(page).to have_content("Log out")
  end

end

feature 'User logout' do

  let!(:user) do
    User.create(email: "john@email.com", first_name: "John", last_name: "Smith", age: 21, password: "helloo", password_confirmation: "helloo")
  end

  scenario 'advises the user they have been logged out and directs them to the log in page' do
    login
    click_link "Log out"
    expect(page).to have_content("Goodbye.  You have been logged out!")
    expect(page).to have_content("Log in")
    expect(page).not_to have_link("Log out")
  end

  scenario 'does not throw error when logout is attempted for a second time (i.e. perhaps from a second window)' do
    login
    click_link "Log out"
    page.driver.delete("/sessions/#{user.id}")
  end
end
