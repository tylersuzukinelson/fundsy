class Api::V1::CampaignsController < Api::V1::BaseController

  def index
    @campaigns = Campaign.published
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def create
    render json: {}
  end

end