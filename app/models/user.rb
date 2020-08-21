class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable

  validates :username, uniqueness: true
  validates :username, presence: true
  validates_acceptance_of :tos_agreement, allow_nil: false, accept: true, on: :create

  has_many :d_meters
  has_many :dooms
  has_many :likes

  # def email_required?
  #   false
  # end
  #
  # def email_changed?
  #   false
  # end

  def liked?(doom_id)
    likes.where(doom_id: doom_id).first ? 'fa fa-thumbs-up' : 'fa fa-thumbs-o-up'
  end
end
