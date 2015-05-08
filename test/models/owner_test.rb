require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @owner = Owner.new(name: "Example Owner", email: "owner@example.com", 
                       password: "foobars", password_confirmation: "foobars")
  end

  test "authenticated? should return false for a owner with nil digest" do
    assert_not @owner.authenticated?(:remember, '')
  end

  test "should be valid" do
    assert @owner.valid?
  end

  test "name should be present" do
    @owner.name = "     "
    assert_not @owner.valid?
  end

  test "email should be present" do 
    @owner.email = "    "
    assert_not @owner.valid?
  end

  test "name should not be too long" do
    @owner.name = "a" * 51
    assert_not @owner.valid?
  end

  test "email should not be too long" do
    @owner.email = "a" * 244
    assert_not @owner.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[owner@example.com OWNER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @owner.email = valid_address
      assert @owner.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do 
    invalid_addresses = %w[owner@example,com owner_at_foo.org owner.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @owner.email = invalid_address
      assert_not @owner.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_owner = @owner.dup
    duplicate_owner.email = @owner.email.upcase    
    @owner.save
    assert_not duplicate_owner.valid?
  end

  test "password should have a minimum length" do
    @owner.password = @owner.password_confirmation = "a" * 6
    assert_not @owner.valid?
  end

  test "associated boutiques should be destroyed" do
    @owner.save
    @owner.boutiques.create!(name: "Lorem ipsum")
    assert_difference 'Boutique.count', -1 do
      @owner.destroy
    end
  end

  
end


