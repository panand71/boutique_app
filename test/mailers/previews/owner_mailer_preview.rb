# Preview all emails at http://localhost:3000/rails/mailers/owner_mailer
class OwnerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/owner_mailer/account_activation
  def account_activation
    owner = Owner.first
    owner.activation_token = Owner.new_token
    OwnerMailer.account_activation(owner)
  end


  # Preview this email at http://localhost:3000/rails/mailers/owner_mailer/password_reset
  def password_reset
    OwnerMailer.password_reset
  end

end


