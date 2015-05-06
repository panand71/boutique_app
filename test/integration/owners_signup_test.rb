require 'test_helper'

class OwnersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Owner.count' do
      post owners_path, owner: { name: "",
                                 email: "user@invalid",
                                 password: "foo",
                                 password_confirmation: "bar"}
    end
    assert_template 'owners/new'
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'Owner.count', 1 do
      post owners_path, owner: { name:  "Example owner",
                               email: "owner@example.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    owner = assigns(:owner)
    assert_not owner.activated?
    # Try to log in before activation.
    log_in_as(owner)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(owner.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(owner.activation_token, email: owner.email)
    assert owner.reload.activated?
    follow_redirect!
    assert_template 'owners/show'
    assert is_logged_in?
  end
end



#     get signup_path
#     assert_difference 'Owner.count', 1 do
#       post_via_redirect owners_path, owner: { name:  "Example Owner",
#                                             email: "owner@example.com",
#                                             password:              "password",
#                                             password_confirmation: "password" }
#     end
#     # these two assertions break the test
#     # assert_template 'owners/show'
#     # assert is_logged_in?
#   end
# end


