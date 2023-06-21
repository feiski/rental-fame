class Offer < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  # Uniqueness: to be tested
  validates :title, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :date, presence: true
  validates :price, presence: true
  has_one_attached :photo
end
