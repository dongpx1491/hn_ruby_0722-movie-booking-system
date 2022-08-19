class ChangeColumTypeFromPayment < ActiveRecord::Migration[6.1]
  def change
    change_column :payments, :status, :integer
    change_column_default :payments, :status, 0
    change_column :payments, :total, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
