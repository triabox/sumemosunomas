require 'test_helper'

class CursosControllerTest < ActionController::TestCase
  setup do
    @curso = cursos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cursos_creados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create curso" do
    assert_difference('Curso.count') do
      post :create, curso: { contenido: @curso.contenido, cupos: @curso.cupos, descripcion: @curso.descripcion, fecha_fin: @curso.fecha_fin, fecha_inicio: @curso.fecha_inicio, lugar: @curso.lugar, nombre: @curso.nombre, relacion_b_nb: @curso.relacion_b_nb }
    end

    assert_redirected_to curso_path(assigns(:curso))
  end

  test "should show curso" do
    get :show, id: @curso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @curso
    assert_response :success
  end

  test "should update curso" do
    patch :update, id: @curso, curso: { contenido: @curso.contenido, cupos: @curso.cupos, descripcion: @curso.descripcion, fecha_fin: @curso.fecha_fin, fecha_inicio: @curso.fecha_inicio, lugar: @curso.lugar, nombre: @curso.nombre, relacion_b_nb: @curso.relacion_b_nb }
    assert_redirected_to curso_path(assigns(:curso))
  end

  test "should destroy curso" do
    assert_difference('Curso.count', -1) do
      delete :destroy, id: @curso
    end

    assert_redirected_to cursos_path
  end
end
