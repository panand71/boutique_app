class AccountActivationsController < ApplicationController
  def edit
    owner = Owner.find_by(email: params[:email])
    if owner && !owner.activated? && owner.authenticated?(:activation, params[:id])
      owner.activate
      log_in owner
      flash[:success] = "Account activated!"
      redirect_to owner
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
