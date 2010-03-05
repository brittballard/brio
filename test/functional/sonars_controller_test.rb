require 'test_helper'

class SonarsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sonars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sonar" do
    assert_difference('Sonar.count') do
      post :create, :sonar => { }
    end

    assert_redirected_to sonar_path(assigns(:sonar))
  end

  test "should show sonar" do
    get :show, :id => sonars(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sonars(:one).to_param
    assert_response :success
  end

  test "should update sonar" do
    put :update, :id => sonars(:one).to_param, :sonar => { }
    assert_redirected_to sonar_path(assigns(:sonar))
  end

  test "should destroy sonar" do
    assert_difference('Sonar.count', -1) do
      delete :destroy, :id => sonars(:one).to_param
    end

    assert_redirected_to sonars_path
  end
end
