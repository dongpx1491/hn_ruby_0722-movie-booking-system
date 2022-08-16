class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|

      t.references :show, null: true, foreign_key: true
      t.references :payment, null: true, foreign_key: true
      t.references :seat, null: true, foreign_key: true

      t.timestamps
    end
  end
end
