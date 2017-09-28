module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Sumemos uno más App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  def esta_finalizado(curso)
    curso.finalizado
  end

  def es_profesor_de(curso)
    if logged_in?
      current_user.id == curso.user_id
    else
      false
    end
  end

  def usuario_es_profesor_de(curso, user)
    user.id == curso.user_id
  end

  def usuario_esta_inactivo(user)
    user.active == '0' or !user.activated
  end

  def soy(user)
    if logged_in?
      current_user.id == user.id
    else
      false
    end
  end

  def es_solicitante_de(recurso)
    if logged_in?
      current_user.id == recurso.user_id
    else
      false
    end
  end

  def esta_inscripto_a(curso)
    if logged_in?
      @alumno_inscripto = Inscripto.where(:user_id => current_user.id).where(:curso_id => curso.id.to_int)
      @alumno_inscripto.any?
    else
      false
    end
  end

  def becado_esta_inscripto_a(curso, alumno)
    if logged_in?
      @alumno_inscripto = Inscripto.where(:user_id => alumno.id).where(:curso_id => curso.id.to_int)
      @alumno_inscripto.any?
    else
      false
    end
  end

  def no_puedo_inscribirlo_a(curso, becadoEnFundacion)
    if logged_in?
      @usuario = User.where(:id => becadoEnFundacion.becado_id).first!
      return becado_esta_inscripto_a(curso, @usuario) || usuario_es_profesor_de(curso, @usuario) || usuario_esta_inactivo(@usuario)
    else
      false
    end
  end

  def cantidad_alumnos_en(curso)
    @alumno_inscripto = Inscripto.where(:curso_id => curso.id.to_int)
    @alumno_inscripto.size.to_s
  end

  def quedan_cupos_becados(curso)
    curso.relacion_b_nb.to_i > 0;
  end

  def quedan_cupos(curso)
    curso.cupos.to_i > 0;
  end

  def no_complete_la_encuesta(curso)
    if logged_in?
      @mis_encuestas = Encuest.where(:encuestador_id => current_user.id).where(:curso_id => curso.id.to_int).where(:completada => false)
      @mis_encuestas.any?
    else
      false
    end
  end

  def completaron_mi_encuesta(curso)
    if logged_in?
      @mis_encuestas = Encuest.where(:encuestado_id => current_user.id).where(:curso_id => curso.id.to_int).where(:completada => true)
      @mis_encuestas.any?
    else
      false
    end
  end

  def soy_el_encuestador(encuesta)
    if logged_in?
      encuesta.encuestador_id == current_user.id
    else
      false
    end
  end

  def soy_padrino_de(alumno)
    return false unless soy_fundacion
    @becadoDeMiFundacion = BecadosPorFundacion.where(:becado_id => alumno.id).where(:fundacion_id => current_user.id)
    @becadoDeMiFundacion.any?
  end

  def puede_ser_apadrinado(usuario)
    es_usuario_comun(usuario) and !soy_padrino_de(usuario)
  end

  def usuarioDe(inscripcion)
    User.find(inscripcion.inscripto.user_id)
  end

  def noIniciaronSesion
    !logged_in?
  end

  def soy_fundacion
    if logged_in?
      current_user.role == "FUNDACION"
    else
      false
    end
  end

  def es_usuario_fundacion(usuario)
    if logged_in?
      usuario.role == "FUNDACION"
    else
      false
    end
  end

  def es_usuario_comun(usuario)
    if logged_in?
      usuario.role == "COMUN"
    else
      false
    end
  end

  def esUsuarioAdministrador
    current_user.role == "ADMIN"
  end

  def noEsUsuarioAdministrador
    !esUsuarioAdministrador
  end

  def noEsUnaFundacion
    !soy_fundacion
  end


  def esta_publicado(curso)
    curso.publicado
  end


  def usuarioById(id)
    User.find(id)
  end

  def paymentById(id)
    PaymentType.find(id)
  end

  def getStatedPayment(inscripto)
    curso = Curso.find(inscripto.curso_id)
    if pago_curso(inscripto, curso)
      return "Pagado"
    else
      return "Pendiente de pago"
    end
  end

  def pago_curso(inscripto, curso)
    if inscripto.tipe == 'Efectivo'
      @inscripciones = Inscripcion.where(:inscripto_id => inscripto.id).where(:pago => false)
      @inscripciones.empty?
    else
      if inscripto.tipe == 'Todo Pago'
        @payment = Payment.find(inscripto.payment_id)
        @payment.state
      else
        true #Alumno Becado
      end
    end
  end

  def pago(curso)
    if logged_in?
      @alumno_inscripto = Inscripto.where(:user_id => current_user.id).where(:curso_id => curso.id).first
      if @alumno_inscripto.tipe == 'Todo Pago'
        @payment = Payment.find(@alumno_inscripto.payment_id)
        @payment.state
      else
        true
      end
    else
      false
    end
  end

  def no_pago(curso)
    !pago(curso)
  end

  def tiene_cuenta_en_todo_pago
    @payments = PaymentType.where(:user_id => current_user.id)
    @payments.any?
  end

  def findPaymentTypeDe(usuario)
    PaymentType.where(:user_id => usuario.id).first
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

end