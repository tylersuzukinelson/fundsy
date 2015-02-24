class Api::V1::CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.published
  end

  def show
    @campaign = Campaign.find params[:id]
  end

end