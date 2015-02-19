class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_campaign

  def create
    @comment = Comment.new comment_params
    @comment.commentable = @commentable
    if @comment.save
      redirect_to @commentable
    else
      flash[:alert]
      render "/#{view_folder}/show"
    end
  end

  private

  def find_campaign
    if params[:campaign_id]
      @commentable = @campaign = Campaign.find params[:campaign_id]
    elsif params[:discussion_id]
      @commentable = @discussion = Discussion.find params[:discussion_id]
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def view_folder
    @commentable.class.name.underscore.pluralize
  end

end
