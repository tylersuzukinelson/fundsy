class CampaignsController < ApplicationController

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new permitted_params
    if @campaign.save
      redirect_to @campaign
    else
      flash[:notice] = error_messages
      render :new
    end
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def index
    @campaigns = Campaign.all
  end

  def edit
    @campaign = Campaign.find params[:id]
  end

  def update
    @campaign = Campaign.find params[:id]
    if @campaign.update permitted_params
      redirect_to @campaign
    else
      flash[:alert] = error_messages
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find params[:id]
    @campaign.destroy
    redirect_to root_path, notice: "Deleted campaign"
  end

  private

  def permitted_params
    params.require(:campaign).permit(:title, :description, :goal, :due_date)
  end

  def error_messages
    @campaign.errors.full_messages.join("; ")
  end

end
