class Campaign < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, numericality: { greater_than_or_equal_to: 10 }

  delegate :full_name, to: :user, prefix: true
end
