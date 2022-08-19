class ChangeColumTypeFromSeat < ActiveRecord::Migration[6.1]
  def change
    rename_column :seats, :type, :type_seat
  end
end
