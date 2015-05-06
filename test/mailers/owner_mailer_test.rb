require 'test_helper'

class OwnerMailerTest < ActionMailer::TestCase
  test "account_activation" do
    owner = owners(:premila)
    owner.activation_token = Owner.new_token
    mail = OwnerMailer.account_activation(owner)
    assert_equal "Account activation", mail.subject
    assert_equal [owner.email], mail.to
    assert_equal ["from@example.com"],   mail.from
    assert_match owner.name,                mail.body.encoded
    assert_match owner.activation_token,    mail.body.encoded
    assert_match CGI::escape(owner.email),  mail.body.encoded
  end

  test "password_reset" do
    owner = owners(:premila)
    owner.reset_token = Owner.new_token
    mail = OwnerMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal [owner.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match owner.reset_token, mail.body.encoded
    assert_match CGI::escape(owner.email), mail.body.encoded
  end

end


