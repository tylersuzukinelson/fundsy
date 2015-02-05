class User < ActiveRecord::Base
  
  has_secure_password
  validates :email, presence: true, uniqueness: true, email: true

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end

end
