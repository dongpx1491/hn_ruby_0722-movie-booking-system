class CreateUserDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_discounts do |t|
      t.references :user, null: true, foreign_key: true
      t.references :discount, null: true, foreign_key: true

      t.timestamps
    end
  end
end
