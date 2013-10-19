module SessionsHelper

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def log_in_user!
    session[:session_token] = @user.reset_session_token!
    redirect_to user_url(@user)
  end

  def created_by_current_user
    if @goal.is_private && @goal.user != current_user
      redirect_to user_url(@goal.user)
    end
  end

  def possible_to_cheer?
    current_user && @goal.user != current_user && !@goal.cheers.pluck(:user_id).include?(current_user.id)
  end

end
