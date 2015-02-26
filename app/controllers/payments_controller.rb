class PaymentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_pledge

  def new
  end

  def create
    render json: params
  end

  private

  def find_pledge
    @pledge = current_user.pledges.find params[:pledge_id]
  end

end
