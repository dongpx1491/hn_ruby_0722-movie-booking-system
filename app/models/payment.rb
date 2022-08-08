class Payment < ApplicationRecord
  enum status: {cancel: 0, finished: 1}
  has_many :tickets, dependent: :destroy
  belong_to :discount
end
