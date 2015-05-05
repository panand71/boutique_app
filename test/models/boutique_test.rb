require 'test_helper'

class BoutiqueTest < ActiveSupport::TestCase

  def setup
    @owner = owners(:premila)
    @boutique = Boutique.new(name: "Fancy Truck", owner_id: @owner.id)
  end

  test "should be valid" do
    assert @boutique.valid?
  end

  test "owner id should be present" do 
    @boutique.owner_id = nil
    assert_not @boutique.valid?
  end
end

