class OwnersController < ApplicationController
  
  def show
    @owner = Owner.find(params[:id])
  end

  def new
    @owner = Owner.new
  end


  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      log_in @owner
      flash[:success] = "Welcome to Fashion Truck US!"
      redirect_to @owner
    else
      render 'new'
    end
  end

  def edit
    @owner = Owner.find(params[:id])
  end

   def update
    @owner = Owner.find(params[:id])
    if @owner.update_attributes(owner_params)
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
end
