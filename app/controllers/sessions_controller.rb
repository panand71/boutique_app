class SessionsController < ApplicationController
  def new
  end

  def create
    owner = Owner.find_by(email: params[:session][:email].downcase)
    if owner && owner.authenticate(params[:session][:password])
      if owner.activated?
        log_in owner
        params[:session][:remember_me] == '1' ? remember(owner) : forget(owner)
        redirect_back_or owner
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
      #redirects to the page they were trying to visit before login
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
