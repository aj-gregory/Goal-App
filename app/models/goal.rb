class Goal < ActiveRecord::Base
  attr_accessible :body, :is_private, :title, :user_id

  validates :body, :title, :user_id, :presence => true

  validates :is_private, :completed, :inclusion => { :in => [true, false] }

  belongs_to :user
  has_many :cheers
end
