class DMeter < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :user
  has_many :dooms, dependent: :destroy

  validates :name, :doom_lvl_0, :doom_lvl_1, :doom_lvl_2, :doom_lvl_3, :doom_lvl_4,
            :doom_lvl_5, :doom_lvl_6, :doom_lvl_7, :doom_lvl_8, :doom_lvl_9, :doom_lvl_10,
            :doom_lvl_11, :doom_lvl_12, :count_days, presence: true
  validates :name, uniqueness: true
  validates_length_of :doom_lvl_0, :doom_lvl_1, :doom_lvl_2, :doom_lvl_3, :doom_lvl_4,
                      :doom_lvl_5, :doom_lvl_6, :doom_lvl_7, :doom_lvl_8, :doom_lvl_9, :doom_lvl_10,
                      :doom_lvl_11, :doom_lvl_12, :count_days, minimum: 1, maximum: 25, allow_blank: true
  validates_length_of :name, minimum: 1, maximum: 30, allow_blank: true

  def levels
    { doom_lvl_0: doom_lvl_0, doom_lvl_1: doom_lvl_1, doom_lvl_2: doom_lvl_2, doom_lvl_3: doom_lvl_3,
      doom_lvl_4: doom_lvl_4, doom_lvl_5: doom_lvl_5, doom_lvl_6: doom_lvl_6, doom_lvl_7: doom_lvl_7,
      doom_lvl_8: doom_lvl_8, doom_lvl_9: doom_lvl_9, doom_lvl_10: doom_lvl_10, doom_lvl_11: doom_lvl_11,
      doom_lvl_12: doom_lvl_12 }.inject({}) { |h, (k, v)| h[v] = k; h }
  end

  def active_dooms
    dooms.where(active: true, created_at: (count_days.days.ago.beginning_of_day..DateTime.now))
  end

  def count_active_dooms
    active_dooms.size
  end

  def count_active_dooms_my_level(lvl)
    active_dooms.where(level: lvl).size
  end

  def current_doom_level
    value_levels = active_dooms.map { |doom| doom.level.split('_').last.to_i }
    value_average = value_levels.present? ? (value_levels.sum * 1.0 / value_levels.size).round(0) : 0
    "doom_lvl_#{value_average}"
  end

  def self.point_level(lvl)
    lvl.split('_').last
  end

  def self.public_list_doom_meters(user)
    (DMeter.where(public: true) + user&.d_meters.to_a + Invite.where(active: true, email: user&.email).map(&:d_meter)).uniq
  end
end
