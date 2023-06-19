class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  # Comments: blank at the moment, to be tested
  # To be tested: A user can only book the same offer one time (one more time?!?)
  validates :user, uniqueness: { scope: :offer }
end
