class BoutiquesController < ApplicationController
  before_action :logged_in_owner, only: [:create, :destroy]
  helper_method :sort_column, :sort_direction


  
  def index
    if params[:search]
      @boutiques = Boutique.search(params[:search]).order(sort_column + " " +sort_direction)
    else
      @boutiques = Boutique.order(sort_column + " " +sort_direction)
    end
  end

  def show
    @boutique = Boutique.find(params[:id])
  end

  def new
    @boutique = Boutique.new
  end
  
  def edit
    @boutique = Boutique.find(params[:id])
  end

  # POST /boutiques
  # POST /boutiques.json
  def create
    @boutique = Boutique.new(boutique_params)

    respond_to do |format|
      if @boutique.save
        format.html { redirect_to @boutique, notice: 'Boutique was successfully created.' }
        format.json { render :show, status: :created, location: @boutique }
      else
        format.html { render :new }
        format.json { render json: @boutique.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boutiques/1
  # PATCH/PUT /boutiques/1.json
  def update
    respond_to do |format|
      if @boutique.update(boutique_params)
        format.html { redirect_to @boutique, notice: 'Boutique was successfully updated.' }
        format.json { render :show, status: :ok, location: @boutique }
      else
        format.html { render :edit }
        format.json { render json: @boutique.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #   @boutique = current_owner.boutiques.build(boutique_params)
  #   if @boutique.save
  #     flash[:success] = "Boutique saved!"
  #     redirect_to root_url
  #   else
  #     render 'static_pages/home'
  #   end
  # end

  def destroy
  end

  def import
    Boutique.import(params[:file])
    redirect_to boutiques_path, notice: "Boutiques uploaded"
  end


  private

  def boutique_params
    params.require(:boutique).permit(:name)
  end
  def sort_column
    Boutique.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end

