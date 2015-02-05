require 'rails_helper'

RSpec.describe User, type: :model do
  def user_attributes(new_attr = {})
    valid_attributes = {
      email: "bob@gmail.com",
      password: "12345678",
      first_name: "Bob",
      last_name: "Smith"
    }
    valid_attributes.merge new_attr
  end

  describe "Validations" do

    it "requires an email" do
      user = User.new user_attributes({email: nil})
      expect(user).to be_invalid
    end

    it "requires a unique email" do
      User.create user_attributes
      user = User.new user_attributes
      expect(user).to be_invalid
    end

    it "requires an email with a valid format" do
      user = User.new user_attributes({email: "bob@gmail"})
      expect(user).to be_invalid
    end

  end

  describe ".full_name" do

    it "returns concatenated first and last names if given" do
      user = User.new user_attributes({first_name: "Bob", last_name: "Smith"})
      expect(user.full_name).to eq("Bob Smith")
    end

    it "returns email if first and last names are not given" do
      user = User.new user_attributes({first_name: nil, last_name: nil, email: "bob@gmail.com"})
      expect(user.full_name).to eq("bob@gmail.com")
    end

  end

end