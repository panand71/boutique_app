class PasswordResetsController < ApplicationController
  before_action :get_owner,   only: [:edit, :update]
  before_action :valid_owner, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]



  def new
  end

  def create
    @owner = Owner.find_by(email: params[:password_reset][:email].downcase)
    if @owner
      @owner.create_reset_digest
      @owner.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if password_blank?
      flash.now[:danger] = "Password can't be blank"
      render 'edit'
    elsif @owner.update_attributes(owner_params)
      log_in @owner
      flash[:success] = "Password has been reset."
      redirect_to @owner
    else
      render 'edit'
    end
  end

  private

  def owner_params
    params.require(:owner).permit(:password, :password_confirmation)
  end


  def get_owner
    @owner = Owner.find_by(email: params[:email])
  end

  def password_blank?
    params[:owner][:password].blank?
  end


    # Confirms a valid owner.
  def valid_owner
      unless (@owner && @owner.activated? &&
        @owner.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @owner.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end
end