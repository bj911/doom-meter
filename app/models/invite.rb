class Invite < ApplicationRecord
  belongs_to :d_meter
  validates :email, uniqueness: { scope: :d_meter_id }
  validates :email, :uid, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
end
