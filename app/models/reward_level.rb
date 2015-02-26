class RewardLevel < ActiveRecord::Base
  belongs_to :campaign

  has_many :pledges, dependent: :nullify

  validates :title, :amount, uniqueness: { scope: :campaign_id }
  validates :title, :body, :amount, :quantity, presence: true
end
