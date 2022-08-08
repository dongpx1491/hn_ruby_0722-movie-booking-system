class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.decimal :total
      t.boolean :status

      t.references :user, null: true, foreign_key: true
      t.references :discount, null: true, foreign_key: true

      t.timestamps
    end
  end
end
