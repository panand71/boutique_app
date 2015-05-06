class OwnerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.owner_mailer.account_activation.subject
  #
  def account_activation(owner)
    @owner = owner
    mail to: owner.email, subject: "Account activation"
  end

 def password_reset(owner)
    @owner = owner
    mail to: owner.email, subject: "Password reset"
  end
end


