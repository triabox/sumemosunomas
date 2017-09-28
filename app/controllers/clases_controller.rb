class ClasesController < ApplicationController
  before_filter :require_login, except: [:show, :index]
  before_action :set_clase, only: [:show, :edit, :update, :destroy, :gestionar, :tomar_asistencia]

  # GET /clases
  # GET /clases.json
  def index
    @clases = Clase.all
  end

  # GET /clases/1
  # GET /clases/1.json
  def show
    @clase.curso = Curso.find @clase.curso_id
  end

  # GET /clases/new
  def new
    @clase = Clase.new
    @clase.curso_id = params[:curso_id]
  end

  # GET /clases/1/edit
  def edit
    @clase.hora_inicio = @clase.hora_inicio.strftime('%H:%M')
    @clase.hora_fin = @clase.hora_fin.strftime('%H:%M')
  end

  # POST /clases
  # POST /clases.json
  def create
    @clase = Clase.new(clase_params)
    respond_to do |format|
      if @clase.save
        @clase.notificar_a_alumnos('create')
        @clase.curso.actualizar_fechas
        format.html { redirect_to curso_path(@clase.curso_id), notice: 'La clase ha sido creada con éxito.' }
        format.json { render :show, status: :created, location: @clase }
      else
        format.html { render :new }
        format.json { render json: @clase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clases/1
  # PATCH/PUT /clases/1.json
  def update
    respond_to do |format|
      if @clase.update(clase_params)
        @clase.curso.actualizar_fechas
        @clase.notificar_a_alumnos('update')
        format.html { redirect_to @clase.curso }
        format.json { render :show, status: :ok, location: @clase }
      else
        format.html { render :edit }
        format.json { render json: @clase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clases/1
  # DELETE /clases/1.json
  def destroy
    @clase.destroy
    @clase.curso.actualizar_fechas
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  def gestionar
    @inscripciones = Inscripcion.where(:clase_id => @clase.id)
  end

  def tomar_asistencia
    params["inscripto"].keys.each do |id|
      @inscripto = Inscripcion.find(id.to_i)
      @inscripto.asistioAClase(params['inscripto'][id]['presencia'])
    end
    redirect_to @clase.curso
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_clase
    @clase = Clase.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def clase_params
    params.require(:clase).permit(:nombre, :descripcion, :contenido, :fecha, :hora_inicio, :hora_fin, :curso_id)
  end
end
