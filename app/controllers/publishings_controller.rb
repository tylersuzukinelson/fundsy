class PublishingsController < ApplicationController

  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    campaign.publish!
    redirect_to campaign, notice: "Campaign Published!"
  end

end
