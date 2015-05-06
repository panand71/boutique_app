class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @owner = owners(:premila)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path, password_reset: { email: @owner.email }
    assert_not_equal @owner.reset_digest, @owner.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    owner = assigns(:owner)
    # Wrong email
    get edit_password_reset_path(owner.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive owner
    owner.toggle!(:activated)
    get edit_password_reset_path(owner.reset_token, email: owner.email)
    assert_redirected_to root_url
    owner.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: owner.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(owner.reset_token, email: owner.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", owner.email
    # Invalid password & confirmation
    patch password_reset_path(owner.reset_token),
          email: owner.email,
          owner: { password:              "foobaz",
                  password_confirmation: "barquux" }
    assert_select 'div#error_explanation'
    # Blank password
    patch password_reset_path(owner.reset_token),
          email: owner.email,
          owner: { password:              "  ",
                  password_confirmation: "foobar" }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    # Valid password & confirmation
    patch password_reset_path(owner.reset_token),
          email: owner.email,
          owner: { password:              "foobaz",
                  password_confirmation: "foobaz" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to owner
  end
end