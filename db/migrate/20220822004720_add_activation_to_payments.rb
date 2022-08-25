class AddActivationToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :activation_digest, :string
    add_column :payments, :activated_at, :datetime
  end
end
