require 'rails_helper'

RSpec.describe Campaign, type: :model do

  describe "Validations" do
    def campaign_attributes(new_attributes)
      valid_attributes = {
                          title: "valid title",
                          description: "valid description",
                          goal: 10000000,
                          due_date: (Time.now + 10.days)
                          }
      valid_attributes.merge(new_attributes)
    end

    it "requires a title" do
      campaign = Campaign.new campaign_attributes(title: nil)
      expect(campaign).to be_invalid
    end

    it "requires a description" do
      campaign = Campaign.new campaign_attributes(description: nil)
      expect(campaign).to be_invalid
    end

    it "requires a goal greater than 10" do
      campaign = Campaign.new campaign_attributes(goal: 5)
      expect(campaign).to be_invalid
    end

    it "requires the title to be unique" do
      Campaign.create campaign_attributes({})
      campaign = Campaign.new campaign_attributes({})
      expect(campaign).to be_invalid
    end  
  end

end
