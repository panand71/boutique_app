require 'test_helper'

class OwnersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @owner = owners(:premila)
  end

  test "index including pagination" do
    log_in_as(@owner)
    get owners_path
    assert_template 'owners/index'
    assert_select 'div.pagination'
    Owner.paginate(page: 1).each do |owner|
      assert_select 'a[href=?]', owner_path(owner), text: owner.name
    end
  end
end

