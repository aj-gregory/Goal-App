class CheersController < ApplicationController

  def create
    @cheer = Cheer.create(:user_id => current_user.id, :goal_id => params[:goal_id])
    redirect_to goal_url(@cheer.goal)
  end

end
