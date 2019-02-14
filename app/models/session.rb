# frozen_string_literal: true

class Session < ApplicationRecord
  validates_presence_of :title, :start_date
  validate :is_user_a_coach? 
  belongs_to :price_table
  belongs_to :coach, class_name: 'User'
  has_many :transactions
  has_and_belongs_to_many :users
  enum status: { scheduled: 0, confirmed: 1, full: 2 }
  before_save :update_members_count

  def set_channel_name
    self.channel_name = title + '_Channel_' + id.to_s
  end

  def is_user_a_coach?
    errors.add(:coach, 'need to be a real Coach') unless self.coach.coach?
  end

  def update_members_count
    self.members_count = self.users.count
  end
end
