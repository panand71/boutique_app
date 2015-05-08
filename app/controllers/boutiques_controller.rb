class BoutiquesController < ApplicationController
  before_action :logged_in_owner, only: [:create, :destroy]

  def create
    @boutique = current_owner.boutiques.build(boutique_params)
    if @boutique.save
      flash[:success] = "Boutique saved!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true, :encoding => 'ISO-8859-1') do |row|
      boutique_hash = row.to_hash
      boutique = Boutique.where(id: boutique_hash["id"])
      if boutique.count == 1
        boutique.first.update_attributes(boutique_hash)
      else
        Boutique.create! (boutique_hash)
      end
    end
  end

  def import
    Boutique.import(params[:file])
    redirect_to boutiques_path, notice: "Boutiques uploaded"
  end


  private

  def boutique_params
    params.require(:boutique).permit(:name)
  end
end

