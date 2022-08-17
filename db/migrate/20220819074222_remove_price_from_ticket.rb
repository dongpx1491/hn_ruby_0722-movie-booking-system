class RemovePriceFromTicket < ActiveRecord::Migration[6.1]
  def change
    remove_column :tickets, :price, :decimal
  end
end
