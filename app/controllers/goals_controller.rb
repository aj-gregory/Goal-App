class GoalsController < ApplicationController

  def new
    render :new
  end

  def create
    params[:goal][:user_id] = current_user.id

    @goal = Goal.new(params[:goal])

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    created_by_current_user
    render :show
  end

  def update
    @goal = Goal.find(params[:id])
    created_by_current_user
    @goal.completed = true
    @goal.save
    render :show
  end

end
