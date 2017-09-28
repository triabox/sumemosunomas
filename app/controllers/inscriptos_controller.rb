class InscriptosController < ApplicationController
  before_action :set_inscripto, only: [:edit, :destroy]
  before_filter :validate_inscripcion, only: [:new, :create]
  before_filter :require_login

  def index
    @inscriptos = Inscripto.all
  end

  def show
    @inscripto = Inscripto.find(params[:id])
  end

  def new
    @inscripto = Inscripto.new
  end

  def newBecado
    @inscripto = Inscripto.new
    @curso= Curso.find(params[:id])
    @alumnosDeMiFundacion = BecadosPorFundacion.where(:fundacion_id => current_user.id)
  end

  def edit
    @inscripto = Inscripto.find(params[:id])
    @curso= @inscripto.curso
  end

  def create
    #Ahora este metodo quedo solo para la inscripcion de alumnos becados
    inscribir_alumno_becado unless noEsUnaFundacion
  end

  def paga_con_tarjeta
    #inscripcion de alumno que paga con tarjeta en todopago
    @curso= Curso.find(params[:curso_id])
    @alumno = User.find(params[:user_id])

    @inscripto = Inscripto.where(:user_id => @alumno.id).where(:curso_id => @curso.id).first

    #PARCHE HORRIBLE
    if (@inscripto.nil?)
      @inscripto = @curso.inscribir(@alumno, false, 'Todo Pago', false)

      @payment = Payment.new
      #El payment type es el del profesor
      @payment.payment_type_id = @curso.user.payment_type.id
      @payment.name = @curso.nombre
      @payment.description = @curso.descripcion
      @payment.state = false
      @payment.amount = @curso.monto
      @payment.save

      @inscripto.payment_id = @payment.id
      @inscripto.save
    end

    @payment = Payment.find(@inscripto.payment_id)
    @response = @payment.open_todopago(current_user, @inscripto.curso);

    if(@response["envelope"]["body"]["send_authorize_request_response"]["status_code"] == "-1")
      redirect_to @response["envelope"]["body"]["send_authorize_request_response"]["url_request"]
    else
      message = @payment.description
      flash[:danger] = message
      redirect_to  edit_inscripto_path(@inscripto)
    end
  end

  def paga_en_efectivo
    #inscripcion de alumno que paga luego en efectivo
    @curso= Curso.find(params[:curso_id])
    @alumno = User.find(params[:user_id])

    respond_to do |format|
      if (@inscripto = @curso.inscribir(@alumno, false, 'Efectivo', false))
        format.html { redirect_to @curso}
        format.json { render :show, status: :created, location: @inscripto }
      else
        format.html { render :new }
        format.json { render json: @inscripto.errors, status: :unprocessable_entity }
      end
    end
  end

  def cambia_pago_a_efectivo
    @curso= Curso.find(params[:curso_id])
    @inscripto = Inscripto.where(:user_id => params[:user_id]).where(:curso_id => params[:curso_id]).first

    respond_to do |format|
      if (@inscripto = @curso.reinscribir(@inscripto, 'Efectivo'))
        format.html { redirect_to @curso}
        format.json { render :show, status: :created, location: @inscripto }
      else
        format.html { render :new }
        format.json { render json: @inscripto.errors, status: :unprocessable_entity }
      end
    end
  end

  def inscribir_alumno_becado
    @curso= Curso.find(params[:curso_id])
    @user= User.find(params[:becado][:id])

    respond_to do |format|
      if (@inscripto = @curso.inscribir(@user, true,'Becado',true))
        format.html { redirect_to @curso}
        format.json { render :show, status: :created, location: @inscripto }
      else
        format.html { render :new }
        format.json { render json: @inscripto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inscripto.destroy
    respond_to do |format|
      format.html { redirect_to inscriptos_url }
      format.json { head :no_content }
    end
  end

  private
  def set_inscripto
    @inscripto = Inscripto.find(params[:id])
  end

  def inscripto_params
    params.require(:inscripto).permit(:tipe)
  end

  def payment_type_params
    params.require(:payment_type).permit(:nombre, :descripcion, :authorization, :merchant,
                                         :telefono, :direccion, :estado, :cod_postal, :ciudad)
  end

  def validate_inscripcion
    @curso = Curso.find(params[:curso_id])
    redirect_to(@curso) unless puede_inscribirse_a(@curso)
  end

  def puede_inscribirse_a(curso)
    !esta_finalizado(curso) and !es_profesor_de(curso) and !esta_inscripto_a(curso)
  end

end
