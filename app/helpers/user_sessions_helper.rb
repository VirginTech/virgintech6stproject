module UserSessionsHelper
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_logged_in?
    !!current_user
  end

  def user_store_location
    session[:forwarding_url] = request.url if request.get?
  end
end