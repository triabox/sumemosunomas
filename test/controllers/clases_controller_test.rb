require 'test_helper'

class ClasesControllerTest < ActionController::TestCase
  setup do
    @clase = clases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clase" do
    assert_difference('Clase.count') do
      post :create, clase: { contenido: @clase.contenido, curso_id: @clase.curso_id, descripcion: @clase.descripcion, fecha: @clase.fecha, hora_fin: @clase.hora_fin, hora_inicio: @clase.hora_inicio, nombre: @clase.nombre }
    end

    assert_redirected_to clase_path(assigns(:clase))
  end

  test "should show clase" do
    get :show, id: @clase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clase
    assert_response :success
  end

  test "should update clase" do
    patch :update, id: @clase, clase: { contenido: @clase.contenido, curso_id: @clase.curso_id, descripcion: @clase.descripcion, fecha: @clase.fecha, hora_fin: @clase.hora_fin, hora_inicio: @clase.hora_inicio, nombre: @clase.nombre }
    assert_redirected_to clase_path(assigns(:clase))
  end

  test "should destroy clase" do
    assert_difference('Clase.count', -1) do
      delete :destroy, id: @clase
    end

    assert_redirected_to clases_path
  end
end
