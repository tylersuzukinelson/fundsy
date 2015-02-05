class Campaign < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, numericality: { greater_than_or_equal_to: 10 }
end
