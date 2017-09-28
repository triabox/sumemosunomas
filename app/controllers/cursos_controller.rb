class CursosController < ApplicationController
  before_filter :validate_finish, only: [:wantToFinish, :finish, :publicar]
  before_action :set_curso, only: [:show, :edit, :update, :destroy, :wantToFinish, :finish]
  before_filter :require_login, except: [:show, :index]
  before_filter :require_permission, only: [:edit, :update, :destroy]


  def require_permission
    if current_user != Curso.find(params[:id]).user
      message = 'No tiene permiso para modificar el curso'
      flash[:danger] = message
      redirect_to root_url
    end
  end

  def index
    @cursos = Curso.search(params[:nombre], params[:zona], params[:tipoActividad],
                           params[:fecha_inicio], params[:fecha_fin], params[:profesor])
    @tipo_de_actividades = @cursos.select(:tipo_actividad).map(&:tipo_actividad).uniq
  end

  def show
    @location = @curso.location
    @clases = Clase.where(:curso => params[:id]).order(:fecha)
    @recursos_solicitados = Recurso.where(:curso => params[:id], :conseguido => false)
    @alumnos_inscriptos = @curso.alumnos_inscriptos
    if (logged_in?)
      @miInscripcion = Inscripto.where(:user_id => current_user.id).where(:curso_id => params[:id])
      if (@miInscripcion.any?)
        @miInscripcion = @miInscripcion.first
      end
    end

    if @location.nil?
      @location = Location.new
      @curso.location = @location
    end
  end

  def new
    @curso = Curso.new
    @curso.location = Location.new

  end

  def edit
  end

  def wantToFinish
  end

  def finish
    @curso.finalizar
    redirect_to(@curso)
  end

  def create
    @curso = Curso.new(curso_params)
    @curso.user_id = current_user.id.to_i
    @curso.location = Location.new(location_params)

    unless (PaymentType.where(:user_id => current_user.id).any?)
      @payment_type = PaymentType.new
      @payment_type.user_id = @curso.user_id
      @payment_type.name = params['payment_type'][0]['name']
      @payment_type.description = params['payment_type'][0]['description']
      @payment_type.tipe = params['payment_type'][0]['tipe']
      @payment_type.authorization = params['payment_type'][0]['authorization']
      @payment_type.merchant = params['payment_type'][0]['merchant']
      @payment_type.save
    end

    respond_to do |format|
      if @curso.save
        @curso.crear_clases(clase_horarios)
        @curso.actualizo_reputacion_profesor
        flash[:success] = "Curso creado! No te olvides de publicarlo para que puedan inscribirse al mismo!"
        format.html { render 'clases/clases', :locals => {:view => 'new', :curso => @curso, :horarios => clase_horarios} }
        format.json { render :show, status: :created, location: @curso }
      else
        format.html { render :new }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @curso.location.update_attributes(location_params)
      if @curso.update(curso_params)
        @curso.notificar_a_alumnos
        format.html { redirect_to @curso }
        format.json { render :show, status: :ok, location: @curso }
      else
        format.html { render :edit }
        format.json { render json: @curso.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @curso.bajar_curso

    respond_to do |format|
      format.html { redirect_to current_user, notice: 'El curso fue eliminado' }
      format.json { head :no_content }

    end
  end

  def publicar
    @curso.publicar
    message = 'Su curso ha sido publicado con éxito!'
    flash[:success] = message
    redirect_to @curso
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_curso
    @curso = Curso.find(params[:id])
    @curso.fecha_inicio = @curso.fecha_inicio.strftime("%d/%m/%Y")
    @curso.fecha_fin = @curso.fecha_fin.strftime("%d/%m/%Y")
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def curso_params
    params.require(:curso).permit(:nombre, :descripcion, :contenido, :fecha_inicio, :fecha_fin, :cupos,
                                  :relacion_b_nb, :user_id, :tipo_actividad, :monto, :efectivo, :tarjeta)
  end

  def clase_horarios
    horarios = [params[:lunes][:inicio], params[:martes][:inicio], params[:miercoles][:inicio],
                params[:jueves][:inicio], params[:viernes][:inicio], params[:sabado][:inicio],
                params[:domingo][:fin], params[:lunes][:fin], params[:martes][:fin],
                params[:miercoles][:fin], params[:jueves][:fin], params[:viernes][:fin],
                params[:sabado][:fin], params[:domingo][:fin]]
  end

  def validate_finish
    @curso = Curso.find(params[:id])
    redirect_to(@curso) unless !esta_finalizado(@curso) and es_profesor_de(@curso)
  end

  def location_params
    params.require(:location).permit(:description, :address, :city, :latitude, :longitude)
    #params.require(:location).permit(:address, :city,:number, :floor,:dep,:postal_code,:state, :latitude, :longitude)
  end


end
