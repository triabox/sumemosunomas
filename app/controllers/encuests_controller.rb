class EncuestsController < ApplicationController
  before_filter :require_login

  def edit
    @curso= Curso.find(params[:curso_id])
    @mis_encuestas = Encuest
                         .where(:encuestador_id => current_user.id)
                         .where(:curso_id => @curso.id)
                         .where(:completada => false)
  end

  def show
    @curso= Curso.find(params[:curso_id])
    @mis_encuestas = Encuest
                         .where(:encuestado_id => current_user.id)
                         .where(:curso_id => @curso.id)
                         .where(:completada => true)
  end

  def completar

    @recomienda = params['encuest']['recomendado'] unless !params['encuest'].present?
    #Completar cuestionario
    params["cuestionario"].keys.each do |id|
      @cuestionario = Cuestionario.find(id.to_i)
      @cuestionario.completarCuestionario(params['cuestionario'][id]['cantEstrellas'],
                                          params['cuestionario'][id]['respuesta'])
    end

    #Completar encuesta y actualizar reputacion
    params["encuesta"].keys.each do |id|
      @encuesta = Encuest.find(id.to_i)
      @encuesta.puntuar(params['encuesta'][id]['comentario'], params['encuesta'][id]['puntuacion'],
                        @recomienda)
      @encuesta.encuestado.notificar_te_puntuaron(@encuesta)
    end

    flash[:success] = "Gracias por completar la encuesta!"
    redirect_to @encuesta.curso
  end

end
