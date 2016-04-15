require 'test_helper'

class TaxisControllerTest < ActionController::TestCase
  setup do
    @taxi = taxis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taxi" do
    assert_difference('Taxi.count') do
      post :create, taxi: { user_id: @taxi.user_id, name: @taxi.name, type: @taxi.type }
    end

    assert_redirected_to taxi_path(assigns(:taxi))
  end

  test "should show taxi" do
    get :show, id: @taxi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @taxi
    assert_response :success
  end

  test "should update taxi" do
    patch :update, id: @taxi, taxi: { user_id: @taxi.user_id, name: @taxi.name, type: @taxi.type }
    assert_redirected_to taxi_path(assigns(:taxi))
  end

  test "should destroy taxi" do
    assert_difference('Taxi.count', -1) do
      delete :destroy, id: @taxi
    end

    assert_redirected_to taxis_path
  end
end
