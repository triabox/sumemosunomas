class Inscripto < ActiveRecord::Base

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :payment
  belongs_to :curso
  has_many :inscripcions


  def crear_inscripciones(pagado)
    curso.clases.each do |clase|
      @inscripcion = Inscripcion.new
      @inscripcion.inscripto_id = self.id
      @inscripcion.clase_id= clase.id
      @inscripcion.pago=pagado
      @inscripcion.save
    end
  end


  def marcar_pagadas_inscripciones
    inscripcions.each do |inscripcion|
      inscripcion.pago = true
      inscripcion.save
    end
  end



   def marcarAsistenciaEnReputacionPara(alumno)
    @reputacion = Reputacion.find_by_user_id(user_id)
    @inscripcionesACursos = Inscripto.where(:user_id => user_id)
    @inscripcionesAClase = []

    @inscripcionesACursos.each do |inscripto|
      @inscripcionesAClase = @inscripcionesAClase + inscripto.inscripcions.to_a
    end

    @cant_asistencias_tomadas = @inscripcionesAClase.count
    @cant_asistencias = 0
    @inscripcionesAClase.each do |inscripcion|
      if inscripcion.presencia
        @cant_asistencias += 1
      end
      if inscripcion.presencia.nil?
        @cant_asistencias_tomadas -= 1
      end
    end
    @PCT_asistencias = @cant_asistencias.to_f / @cant_asistencias_tomadas * 100
    @reputacion.update_asistencia_a_clase(@PCT_asistencias)

  end

end
