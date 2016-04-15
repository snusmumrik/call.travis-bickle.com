require 'test_helper'

class PersonInChargesControllerTest < ActionController::TestCase
  setup do
    @person_in_charge = person_in_charges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:person_in_charges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person_in_charge" do
    assert_difference('PersonInCharge.count') do
      post :create, person_in_charge: { user_id: @person_in_charge.user_id, name: @person_in_charge.name }
    end

    assert_redirected_to person_in_charge_path(assigns(:person_in_charge))
  end

  test "should show person_in_charge" do
    get :show, id: @person_in_charge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person_in_charge
    assert_response :success
  end

  test "should update person_in_charge" do
    patch :update, id: @person_in_charge, person_in_charge: { user_id: @person_in_charge.user_id, name: @person_in_charge.name }
    assert_redirected_to person_in_charge_path(assigns(:person_in_charge))
  end

  test "should destroy person_in_charge" do
    assert_difference('PersonInCharge.count', -1) do
      delete :destroy, id: @person_in_charge
    end

    assert_redirected_to person_in_charges_path
  end
end
