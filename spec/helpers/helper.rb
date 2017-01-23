def signup(email: "john@email.com", first_name: "John", last_name: "Smith", age: 21, password: "helloo", password_confirmation: "helloo" )
  visit '/users/new'
  fill_in :user_email, :with => email
  fill_in :user_first_name, :with => first_name
  fill_in :user_last_name, :with => last_name
  fill_in :user_password, :with => password
  fill_in :user_password_confirmation, :with => password_confirmation
  click_button :submit
end

def login(email: "john@email.com", password: "helloo")
  visit '/sessions/new'
  fill_in :session_email, :with => email
  fill_in :session_password, :with => password
  click_button :submit
end
