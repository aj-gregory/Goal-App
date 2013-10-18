class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      log_in_user!
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @goals = @user.goals
    render :show
  end

end
