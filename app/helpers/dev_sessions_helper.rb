module DevSessionsHelper
  
  def current_developer
    @current_developer ||= Developer.find_by(id: session[:developer_id])
  end

  def dev_logged_in?
    !!current_developer
  end

  def dev_store_location
    session[:forwarding_url] = request.url if request.get?
  end
end