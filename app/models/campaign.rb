class Campaign < ActiveRecord::Base
  include AASM

  belongs_to :user

  has_many :reward_levels, dependent: :destroy
  accepts_nested_attributes_for :reward_levels, 
    reject_if: lambda { |x|
      x[:amount].blank? && 
      x[:title].blank? && 
      x[:body].blank? && 
      x[:quantity].blank?
    }

  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, numericality: { greater_than_or_equal_to: 10 }
  validates :reward_levels, presence: true

  scope :published, -> { where(aasm_state: :published) }

  delegate :full_name, to: :user, prefix: true

  aasm do
    state :draft, initial: true
    state :published
    state :funded
    state :unfunded
    state :cancelled

    event :publish do
      transitions from: :draft, to: :published
    end

    event :cancel do
      transitions from: [:published, :funded], to: :cancelled
    end

    event :fund do
      transitions from: :published, to: :funded
    end

    event :unfund do
      transitions from: :fund, to: :unfunded
    end
  end
end
