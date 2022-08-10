class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.decimal :total, default: 0, precision: 10, scale: 2
      t.integer :status, default: 0

      t.references :user, null: true, foreign_key: true
      t.references :discount, null: true, foreign_key: true

      t.timestamps
    end
  end
end
