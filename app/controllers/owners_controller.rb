class OwnersController < ApplicationController

  before_action :logged_in_owner, only: [:index, :edit, :update]
  before_action :correct_owner,   only: [:edit, :update]
  before_action :admin_owner,     only: :destroy

  def index
    @owners = Owner.paginate(page: params[:page])
  end
 
  def show
    @owner = Owner.find(params[:id])
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      @owner.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # log_in @owner
      # flash[:success] = "Welcome to Fashion Truck US!"
      # redirect_to @owner
    else
      render 'new'
    end
  end


  def edit
    @owner = Owner.find(params[:id])
  end

  def destroy
    Owner.find(params[:id]).destroy
    flash[:success] = "Owner deleted"
    redirect_to owners_url
  end

   def update
    @owner = Owner.find(params[:id])
    if @owner.update_attributes(owner_params)
      flash[:success] = "Profile updated"
      redirect_to @owner
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  private

    def owner_params
      params.require(:owner).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_owner
      @owner = Owner.find(params[:id])
      # redirect_to(root_url) unless @owner == current_owner
      redirect_to(root_url) unless current_owner?(@owner)  
    end

    def admin_owner
      redirect_to(root_url) unless current_owner.admin?
    end
end
