class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:new , :create, :edit, :update, :destroy]
  before_action :find_campaign, only: [:show]
  before_action :find_own_campaign, only: [:edit, :update, :destroy]

  def new
    @campaign = Campaign.new
    3.times { @campaign.reward_levels.build }
  end

  def create
    @campaign = Campaign.new permitted_params
    @campaign.user = current_user
    if @campaign.save
      expire_fragment "recent-campaigns"
      flash[:notice] = "Campaign created!"
      redirect_to @campaign
    else
      remaining = 3 - @campaign.reward_levels.count
      3.times { @campaign.reward_levels.build }
      flash[:notice] = error_messages
      render :new
    end
  end

  def show
  end

  def index
    @campaigns = Campaign.published
    @recent_campaigns = Campaign.published.recent(3)
  end

  def edit
    remaining = 3 - @campaign.reward_levels.count
    remaining.times { @campaign.reward_levels.build }
  end

  def update
    if @campaign.update permitted_params
      redirect_to @campaign
    else
      flash[:alert] = error_messages
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to root_path, notice: "Deleted campaign"
  end

  private

  def permitted_params
    params.require(:campaign).permit(:title, :description, :goal, :due_date, { reward_levels_attributes: [:id, :title, :amount, :quantity, :body, :_destroy] })
  end

  def error_messages
    @campaign.errors.full_messages.join("; ")
  end

  def find_campaign
    @campaign = Campaign.includes(:comments, :reward_levels).references(:comments, :reward_levels).find(params[:id]).decorate
    # @campaign = CampaignsControllermpaign.find params[:id]
  end

  def find_own_campaign
    @campaign  = current_user.campaigns.find(params[:id]).decorate
  end

end
