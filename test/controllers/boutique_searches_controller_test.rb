require 'test_helper'

class BoutiqueSearchesControllerTest < ActionController::TestCase
  setup do
    @boutique_search = boutique_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boutique_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boutique_search" do
    assert_difference('BoutiqueSearch.count') do
      post :create, boutique_search: { boutique_id: @boutique_search.boutique_id, boutique_name: @boutique_search.boutique_name, category: @boutique_search.category, city: @boutique_search.city, keywords: @boutique_search.keywords, new: @boutique_search.new, show: @boutique_search.show, state: @boutique_search.state }
    end

    assert_redirected_to boutique_search_path(assigns(:boutique_search))
  end

  test "should show boutique_search" do
    get :show, id: @boutique_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boutique_search
    assert_response :success
  end

  test "should update boutique_search" do
    patch :update, id: @boutique_search, boutique_search: { boutique_id: @boutique_search.boutique_id, boutique_name: @boutique_search.boutique_name, category: @boutique_search.category, city: @boutique_search.city, keywords: @boutique_search.keywords, new: @boutique_search.new, show: @boutique_search.show, state: @boutique_search.state }
    assert_redirected_to boutique_search_path(assigns(:boutique_search))
  end

  test "should destroy boutique_search" do
    assert_difference('BoutiqueSearch.count', -1) do
      delete :destroy, id: @boutique_search
    end

    assert_redirected_to boutique_searches_path
  end
end
