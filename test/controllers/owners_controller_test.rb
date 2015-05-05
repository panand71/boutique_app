require 'test_helper'

class OwnersControllerTest < ActionController::TestCase

  def setup
    @owner = owners(:premila)
    @other_owner = owners(:suj)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @owner
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @owner, owner: { name: @owner.name, email: @owner.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end


  test "should redirect edit when logged in as wrong owner" do
    log_in_as(@other_owner)
    get :edit, id: @owner
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong owner" do
    log_in_as(@other_owner)
    patch :update, id: @owner, owner: { name: @owner.name, email: @owner.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

    test "should redirect destroy when not logged in" do
    assert_no_difference 'Owner.count' do
      delete :destroy, id: @owner
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_owner)
    assert_no_difference 'Owner.count' do
      delete :destroy, id: @owner
    end
    assert_redirected_to root_url
  end

end
