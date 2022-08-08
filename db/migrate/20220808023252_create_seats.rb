class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.integer :type
      t.decimal :price

      t.references :room, null: true, foreign_key: true

      t.timestamps
    end
  end
end
