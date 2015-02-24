class Api::V1::BaseController < ApplicationController
  
  before_action :authorize_access
  skip_before_action :verify_authenticity_token

  private

  def authorize_access
    @user = User.find_by_api_key params[:api_key]
    head :unauthorized unless @user # Renders a 401 server request (Unauthorized)
  end

end