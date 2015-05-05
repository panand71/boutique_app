class StaticPagesController < ApplicationController
  def home
    @boutique = current_owner.boutiques.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
