class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create]
  before_filter :validate_apadrinar, only: [:quieroApadrinar, :apadrinar]
  before_action :set_becado, only: [:quieroApadrinar, :apadrinar]

  before_filter :require_permission, only: [:edit, :update, :destroy]

  def require_permission
    if current_user != User.find(params[:id])

      message = 'No tiene permiso para modificar el usuario'
      flash[:danger] = message
      redirect_to root_url
    end
  end

  def show
    @user = User.find(params[:id])
    @habilidades = @user.habilidades.split(",") unless @user.habilidades.nil?
    @location = @user.location
    @cursos_creados = Curso.where(:user_id => @user.id)
    @cursos_inscriptos = Curso.where(:id => (Inscripto.select(:curso_id).where(:user_id => @user.id)))
    @user =  @user.initialize_location
    @becados_por_fundacion = User.where(:id => (BecadosPorFundacion.select(:becado_id).where(:fundacion_id => @user.id)))
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if create_user(@user)
      if noIniciaronSesion or noEsUsuarioAdministrador
        @user.send_activation_email
        flash[:info] = "Se ha enviado un email al mail registrado. Se debe activar la cuenta desde el mismo!"
        redirect_to root_url
        return
      else
        flash[:success] = "Fundación creada!"
        @user.notificar_alta_fundacion
      end
      redirect_to @user
    else
      render 'new'
    end

  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_location(location_params)
    if @user.update_attributes(user_params)
      flash[:success] = "Su perfil ha sido modificado con éxito"
      redirect_to @user
    else
      flash[:danger] = "No se pudo actualizar el perfil por: " + @user.errors.full_messages.join(",")
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.bajar_usuario
      flash[:success] = "El usuario fue desactivado!"
      log_out if logged_in?
      redirect_to root_url
    else
      flash[:danger] = "No se pudo desactivar el perfil: " + @user.errors.full_messages.join(",")
      redirect_to @user
    end
  end

  def foundation
    @user = User.new
    @users = @user.list_user_foundation
  end

  def foundation_desactivar
    @user = User.find params[:id]
    if @user.bajar_usuario
      flash[:success] = "La fundacion fue desactivada!"
      redirect_to foundation_path
    else
      flash[:danger] = "Error al desactivar la fundacion!"
      redirect_to foundation_path
    end
  end


  def search
    @users = User.search(params[:search])
  end

  def quieroApadrinar
  end

  def apadrinar
    @nuevo_becado = BecadosPorFundacion.create(:becado_id => @usuario_a_apadrinar.id, :fundacion_id => current_user.id)
    redirect_to(@usuario_a_apadrinar)
  end

  private

  def user_params
    params.require(:user).permit(:name,:imagen, :lastname, :email, :password, :phone,
                                 :password_confirmation, :experiencia, :habilidades, :notas)
  end
  def location_params
    params.require(:location).permit(:description,:address, :city,:number, :floor,:dep,:postal_code,:state, :latitude, :longitude)
  end

  def validate_apadrinar
    @usuario_a_apadrinar = User.find(params[:id])
    redirect_to(root_path) if soy_padrino_de(@usuario_a_apadrinar)
  end

  def set_becado
    @usuario_a_apadrinar = User.find(params[:id])
  end

  def create_user(user)
    response = false
    user.active = 1

    if noIniciaronSesion or noEsUsuarioAdministrador
      user.role = 'COMUN'
      if user.save
        response = true
        create_reputacion_para(user)
      end
    else
      user.role = 'FUNDACION'
      if user.save
        response = true
        user.activate
        create_reputacion_para(user)
      end
    end

    if soy_fundacion
      @nuevo_becado = BecadosPorFundacion.create(:becado_id => user.id, :fundacion_id => current_user.id)
    end

    return response
  end

  def create_reputacion_para(user)
    @reputacion = Reputacion.create
    @reputacion.user_id = user.id
    @reputacion.save
  end
end