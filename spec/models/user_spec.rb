require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) do
    User.new(email: "john@email.com", first_name: "John", last_name: "Smith", age: 21, password: "helloo", password_confirmation: "helloo")
  end

  context 'validations' do
    it 'validates a user with all attributes completed' do
      expect(user).to be_valid
    end

    it 'invalidates a user with no email address' do
      user.email = ""
      expect(user).not_to be_valid
    end

    it 'invalidates a user with no first name' do
      user.first_name = ""
      expect(user).not_to be_valid
      user.first_name = "John"
      user.last_name = ""
      expect(user).not_to be_valid
    end

    it 'invalidates a user with no last name' do
      user.last_name = ""
      expect(user).not_to be_valid
    end

    it 'invalidates a user if first or last name is too short (less than 2 characters)' do
      user.first_name = "X"
      expect(user).not_to be_valid
      user.first_name = "John"
      user.last_name = "X"
      expect(user).not_to be_valid
    end

    it 'validates a user if email address is in recognised format' do
      valid_address = %w[john@email.com john.smith@email.co.uk john.smith@email.com john@email.org]
      valid_address.each do |address|
        user.email = address
        expect(user).to be_valid
      end
    end

    it 'invalidates a user if email address is not in recognised format' do
      invalid_address = %w[john@email,com john_at_email.co.uk john.smith@email john@smith_email.com]
      invalid_address.each do |address|
        user.email = address
        expect(user).not_to be_valid
      end
    end

    it 'invalidates an user if email address is not unique' do
      user.save
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      expect(duplicate_user).to_not be_valid
    end

    it 'validates that a password is present' do
      user.password = user.password_confirmation = " " * 6
      expect(user).not_to be_valid
    end

    it 'validates that a password has 6 characters' do
      user.password = user.password_confirmation = "a" * 5
      expect(user).not_to be_valid
    end
  end

  context '#create_remember_token' do
    it 'should create a token and digest, saving the digest into the user in the database' do
      user.create_remember_token
      expect(user.remember_token).not_to eq(nil)
      expect(user.reload.remember_token).not_to eq(nil)
    end
  end

  context '#athenticated_remember_token' do
    it 'should return false for user with a nil digest
    (simulating the situation where the app is open in two browsers,
    the user logs out in the first browser, then closes the second without logging out)' do
      expect(user.authenticate_token('', 'remember')).to eq(false)
    end
  end

  context '#forget' do
    it 'should set remember_digest attribute of the user to nil in the database' do
      user.update_attribute(:remember_digest, "test_digest")
      user.forget
      expect(user.reload.remember_digest).to eq(nil)
    end
  end



end
