class BoutiqueSearchesController < ApplicationController
  before_action :set_boutique_search, only: [:show, :edit, :update, :destroy]

  # GET /boutique_searches
  # GET /boutique_searches.json
  def index
    @boutique_searches = BoutiqueSearch.all
  end

  # GET /boutique_searches/1
  # GET /boutique_searches/1.json
  def show
  end

  # GET /boutique_searches/new
  def new
    @boutique_search = BoutiqueSearch.new
  end

  # GET /boutique_searches/1/edit
  def edit
  end

  # POST /boutique_searches
  # POST /boutique_searches.json
  def create
    @boutique_search = BoutiqueSearch.new(boutique_search_params)

    respond_to do |format|
      if @boutique_search.save
        format.html { redirect_to @boutique_search, notice: 'Boutique search was successfully created.' }
        format.json { render :show, status: :created, location: @boutique_search }
      else
        format.html { render :new }
        format.json { render json: @boutique_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boutique_searches/1
  # PATCH/PUT /boutique_searches/1.json
  def update
    respond_to do |format|
      if @boutique_search.update(boutique_search_params)
        format.html { redirect_to @boutique_search, notice: 'Boutique search was successfully updated.' }
        format.json { render :show, status: :ok, location: @boutique_search }
      else
        format.html { render :edit }
        format.json { render json: @boutique_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boutique_searches/1
  # DELETE /boutique_searches/1.json
  def destroy
    @boutique_search.destroy
    respond_to do |format|
      format.html { redirect_to boutique_searches_url, notice: 'Boutique search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boutique_search
      @boutique_search = BoutiqueSearch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boutique_search_params
      params.require(:boutique_search).permit(:keywords, :boutique_id, :boutique_name, :category, :city, :state, :new, :show)
    end
end
