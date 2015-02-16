class RewardLevel < ActiveRecord::Base
  belongs_to :campaign

  validates :title, :amount, uniqueness: { scope: :campaign_id }
  validates :title, :body, :amount, :quantity, presence: true
end
