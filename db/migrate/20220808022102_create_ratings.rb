class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.text :comment
      t.float :rate
      t.boolean :favorite

      t.references :user, null: true, foreign_key: true
      t.references :movie, null: true, foreign_key: true

      t.timestamps
    end
  end
end
