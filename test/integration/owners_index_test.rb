require 'test_helper'

class OwnersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = owners(:premila)
    @non_admin = owners(:suj)
  end



    test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get owners_path
    assert_template 'owners/index'
    assert_select 'div.pagination'
    first_page_of_owners = Owner.paginate(page: 1)
    first_page_of_owners.each do |owner|
      assert_select 'a[href=?]', owner_path(owner), text: owner.name
      unless owner == @admin
        assert_select 'a[href=?]', owner_path(owner), text: 'delete',
                                                    method: :delete
      end
    end
    assert_difference 'Owner.count', -1 do
      delete owner_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get owners_path
    assert_select 'a', text: 'delete', count: 0
  end
end


