class AddActivationDigestToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activation_sent_at, :datetime
    add_column :users, :account_activated, :boolean
  end
end
