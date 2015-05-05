module SessionsHelper
  def log_in(owner)
    session[:owner_id] = owner.id
  end

  def remember(owner)
    owner.remember
    cookies.permanent.signed[:owner_id] = owner.id
    cookies.permanent[:remember_token] = owner.remember_token
  end


  def current_owner
    if (owner_id = session[:owner_id])
      @current_owner || Owner.find_by(id: owner_id)
    elsif (owner_id = cookies.signed[:owner_id])  
      owner = Owner.find_by(id: owner_id)
      if owner && owner.authenticated?(cookies[:remember_token])
        log_in owner
        @current_owner = owner
      end
    end
  end

  def current_owner?(owner)
    owner == current_owner
  end

  def logged_in?
    !current_owner.nil?
  end

  def forget(owner)
    owner.forget
    cookies.delete(:owner_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_owner)
    session.delete(:owner_id)
    @current_owner = nil
  end

    # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
