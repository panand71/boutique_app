require 'test_helper'

class OwnersSignupTest < ActionDispatch::IntegrationTest
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
end


