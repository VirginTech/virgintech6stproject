module DevSessionsHelper
  
  def current_developer
    @current_developer ||= Developer.find_by(id: session[:developer_id])
  end

  def dev_logged_in?
    !!current_developer
  end

  def same_developer?(dev_id)
    flg=false
    if dev_logged_in?
      if current_developer.id == dev_id.to_i
        flg=true
      end
    end
  end

  def dev_store_location
    session[:forwarding_url] = request.url if request.get?
  end
end