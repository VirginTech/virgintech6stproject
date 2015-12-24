module UserSessionsHelper
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    !!current_user
  end

  def same_user?(user_id)
    flg=false
    if user_logged_in?
      if current_user.id == user_id.to_i
        flg=true
      end
    end
  end
    
  def user_store_location
    session[:forwarding_url] = request.url if request.get?
  end
end