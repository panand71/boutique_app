class BoutiquesController < ApplicationController
    before_action :logged_in_owner, only: [:create, :destroy]

    def create
      @boutique = current_owner.boutique.build(boutique_params)
      if @boutique.save
        flash[:success] = "Boutique saved!"
        redirect_to root_url
      else
        render 'static_pages/home'
      end
    end

    def destroy
    end

    private

    def boutique_params
      params.require(:boutique).permit(:name)
    end
end

