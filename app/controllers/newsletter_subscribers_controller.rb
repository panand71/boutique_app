class NewsletterSubscribersController < ApplicationController
  def new
    @newsletter_subscriber = Newsletter_Subscriber.new
  end

  def create
    @newsletter_subscriber = Newsletter_subscriber.new(params[:newsletter_subscriber])
    @newsletter_subscriber.request = request
    if @newsletter_subscriber.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
    else
      flash.now[:error] = 'Your message cannot be sent.'
      render :new
    end
  end
end
