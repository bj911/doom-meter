class Doom < ApplicationRecord
  belongs_to :user
  belongs_to :d_meter
  has_many :likes

  validates :level, :text, presence: true
  validates_length_of :text, minimum: 1, maximum: 50, allow_blank: true

  after_create :change_last_active_doom

  private
  def change_last_active_doom
    dooms = d_meter.dooms.order(:created_at).where(user_id: user_id, created_at: (created_at.beginning_of_day..created_at.end_of_day))
    dooms[-2].update(active: false) if dooms.size > 1
  end
end
