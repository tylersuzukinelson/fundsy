class User < ActiveRecord::Base
  has_secure_password
  has_many :campaigns, dependent: :destroy

  validates :email, presence: true, uniqueness: true, email_format: true

  before_create :generate_api_key

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  private

  def generate_api_key
    self.api_key = SecureRandom.hex
  end

end
