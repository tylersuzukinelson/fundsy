class PledgesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_reward_level

  def index

  end

  def new
    @pledge = Pledge.new amount: @reward_level.amount
  end

  def create
    @pledge = Pledge.new pledge_params
    @pledge.reward_level = @reward_level
    @pledge.user = current_user
    if @pledge.save
      redirect_to new_pledge_payment_path(@pledge)
    else
      flash[:alert] = get_errors
      render :new
    end
  end

  def destroy

  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount)
  end

  def find_reward_level
    @reward_level = RewardLevel.find params[:reward_level_id]
  end

  def get_errors
    @pledge.errors.full_messages.join('; ')
  end

end
