class OwnersController < ApplicationController
  def new
    @owner = Owner.new
  end

  def show
    @owner = Owner.find(params[:id])
    debugger
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      flash[:success] = "Welcome to Fashion Truck US!"
      redirect_to @owner
    else
      render 'new'
    end
  end

  private

    def owner_params
      params.require(:owner).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
