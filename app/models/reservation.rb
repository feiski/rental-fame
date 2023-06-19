#  To be checked: One user cannot book his own offer
# class UserValidator < ActiveModel::Validator

  #   def validate(record)
#     if record.user == record.offer.user
#       record.errors.add :base, "Cannot book your own offer!"
#     end
#   end
# end

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  # Comments: blank at the moment, to be tested
  # To be tested: A user can only book the same offer one time (one more time?!?)
  validates :user, uniqueness: { scope: :offer }
  # validates_with UserValidator // see above
end
