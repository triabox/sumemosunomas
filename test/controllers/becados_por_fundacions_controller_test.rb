require 'test_helper'

class BecadosPorFundacionsControllerTest < ActionController::TestCase
  setup do
    @becados_por_fundacion = becados_por_fundacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:becados_por_fundacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create becados_por_fundacion" do
    assert_difference('BecadosPorFundacion.count') do
      post :create, becados_por_fundacion: { becado_id: @becados_por_fundacion.becado_id, fundacion_id: @becados_por_fundacion.fundacion_id }
    end

    assert_redirected_to becados_por_fundacion_path(assigns(:becados_por_fundacion))
  end

  test "should show becados_por_fundacion" do
    get :show, id: @becados_por_fundacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @becados_por_fundacion
    assert_response :success
  end

  test "should update becados_por_fundacion" do
    patch :update, id: @becados_por_fundacion, becados_por_fundacion: { becado_id: @becados_por_fundacion.becado_id, fundacion_id: @becados_por_fundacion.fundacion_id }
    assert_redirected_to becados_por_fundacion_path(assigns(:becados_por_fundacion))
  end

  test "should destroy becados_por_fundacion" do
    assert_difference('BecadosPorFundacion.count', -1) do
      delete :destroy, id: @becados_por_fundacion
    end

    assert_redirected_to becados_por_fundacions_path
  end
end
