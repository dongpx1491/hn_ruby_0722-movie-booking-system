class Payment < ApplicationRecord
  enum status: {inactive: 0, active: 1}
  has_many :tickets, dependent: :destroy
end
