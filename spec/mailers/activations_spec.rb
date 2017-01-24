require "rails_helper"

RSpec.describe ActivationsMailer, type: :mailer do

  let!(:user) do
    User.new(email: "john@email.com", first_name: "John", last_name: "Smith", age: 21, password: "helloo", password_confirmation: "helloo")
  end

  context 'activation_email' do

    it 'sends activation email to user' do
      user.save
      user.create_activation_token
      mail = ActivationsMailer.activation_email(user).deliver_now
      expect(mail.subject).to eq("Account Activation")
      expect(mail.to).to eq(["john@email.com"])
      expect(mail.from).to eq(["from@example.com"])
      expect(mail.body.encoded).to include("Please click the following link to activate you account:")
      expect(mail.body.encoded).to include(user.id.to_s)
      expect(mail.body.encoded).to include(user.activation_token)
    end
  end

end
