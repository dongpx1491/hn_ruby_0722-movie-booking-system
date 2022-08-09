class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :code
      t.float :rate
      t.decimal :condition

      t.timestamps
    end
  end
end
