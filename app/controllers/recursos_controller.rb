class RecursosController < ApplicationController
  before_action :set_recurso, only: [:show, :edit, :update, :destroy, :conseguido]
  before_filter :validar_conseguido , only: [:conseguido,:destroy]
  before_filter :require_login
  before_filter :require_permission, only: [:edit, :update, :destroy,:conseguido]

  def require_permission
    if !es_solicitante_de(Recurso.find(params[:id]))
      message = 'No tiene permiso para modificar este material'
      flash[:danger] = message
      redirect_to(@recurso)
    end
  end

  def index
    @recursos = Recurso.search(params[:nombre],params[:profesor])
    @categorias = @recursos.select(:tipe).map(&:tipe).uniq
  end

  def show
    @recurso = Recurso.find(params[:id])
  end

  def new
    @recurso = Recurso.new
    @curso= Curso.find(params[:id])
    @recurso.curso = @curso
  end

  def edit
    @curso= Curso.find(@recurso.curso.id)
  end

  def create
    @curso= Curso.find(params[:curso_id])
    respond_to do |format|
      @recurso = @curso.crear_recurso(recurso_params)
      if (@recurso.save)
        format.html { redirect_to @curso}
        format.json { render :show, status: :created, location: @recurso }
      else
        format.html { render :new }
        format.json { render json: @recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recurso.update(recurso_params)
        format.html { redirect_to curso_path(@recurso.curso_id)}
        format.json { render :show, status: :ok, location: @recurso }
      else
        format.html { render :edit }
        format.json { render json: @recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recurso.destroy
    respond_to do |format|
      format.html { redirect_to recursos_url }
      format.json { head :no_content }
    end
  end

  def conseguido
    @recurso.conseguir
    redirect_to :back
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_recurso
    @recurso = Recurso.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recurso_params
    params.require(:recurso).permit(:nombre,:tipe,:description)
  end

  def validar_conseguido
      @recurso = Recurso.find(params[:id])
      redirect_to(@recurso) unless es_solicitante_de(@recurso)
  end


end
