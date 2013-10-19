class Cheer < ActiveRecord::Base
  attr_accessible :goal_id, :user_id

  validates :goal_id, :user_id, :presence => true

  belongs_to :goal
  belongs_to :user
end
