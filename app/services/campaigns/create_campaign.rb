class Campaigns::CreateCampaign

  include Virtus.model

  attribute :params, Hash
  attribute :user, User
  attribute :campaign, Campaign

  def call
    @campaign = Campaign.new params
    @campaign.user = user
    @campaign.save
  end

end