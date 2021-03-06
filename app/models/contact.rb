class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :shipping_country
  attribute :nickname,  :captcha  => true
  attribute :newsletter

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Fashion Truck US Contact Form",
      :to => "panand71@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end