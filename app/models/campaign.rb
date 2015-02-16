class Campaign < ActiveRecord::Base
  belongs_to :user

  has_many :reward_levels, dependent: :destroy
  accepts_nested_attributes_for :reward_levels, 
    reject_if: lambda { |x|
      x[:amount].blank? && 
      x[:title].blank? && 
      x[:body].blank? && 
      x[:quantity].blank?
    }
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, numericality: { greater_than_or_equal_to: 10 }
  validates :reward_levels, presence: true

  delegate :full_name, to: :user, prefix: true
end
