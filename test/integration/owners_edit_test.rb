require 'test_helper'

class OwnersEditTest < ActionDispatch::IntegrationTest

  def setup
    @owner = owners(:premila)
  end

  test "unsuccessful edit" do 
    log_in_as(@owner)
    get edit_owner_path(@owner)
    assert_template 'owners/edit'
    patch owner_path(@owner), owner: { name: "",
     email: "foo@invalid",
     password: "foo",
     password_confirmation: "bar"}
     assert_template 'owners/edit'
   end


   test "successful edit with friendly forwarding" do
    get edit_owner_path(@owner)
    log_in_as(@owner)
    assert_redirected_to edit_owner_path(@owner)
    log_in_as(@owner)
    get edit_owner_path(@owner)
    assert_template 'owners/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch owner_path(@owner), owner: { name:  name,
      email: email,
      password:              "",
      password_confirmation: "" }
      assert_not flash.empty?
      assert_redirected_to @owner
      @owner.reload
      assert_equal @owner.name,  name
      assert_equal @owner.email, email
    end

  test "successful edit" do
    log_in_as(@owner)
    get edit_owner_path(@owner)
    assert_template 'owners/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch owner_path(@owner), owner: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @owner
    @owner.reload
    assert_equal @owner.name,  name
    assert_equal @owner.email, email
  end
end
