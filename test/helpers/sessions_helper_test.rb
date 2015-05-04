require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @owner = owners(:premila)
    remember(@owner)
  end

  test "current_owner returns right owner when session is nil" do
    assert_equal @owner, current_owner
    assert is_logged_in?
  end

  test "current_owner returns nil when remember digest is wrong" do
    @owner.update_attribute(:remember_digest, Owner.digest(Owner.new_token))
    assert_nil current_owner
  end
end