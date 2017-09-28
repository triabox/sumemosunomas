class Encuest < ActiveRecord::Base
  belongs_to :curso
  belongs_to :encuestado, class_name: "User"
  belongs_to :encuestador, class_name: "User"
  has_many :cuestionarios, foreign_key: "encuesta_id"

  def puntuar(comentario, estrellas, recomendado)
    self.update_attribute(:comentario, comentario)
    self.update_attribute(:puntuacion, estrellas)
    self.update_attribute(:completada, true)
    self.save

    @reputacion = self.encuestado.reputacion
    #Calculo reputacion como Profesor
    if encuestado_id == curso.user_id
      @enc_como_profesor = Encuest.where("encuestado_id = ?" , self.encuestado_id).joins(:curso)
                               .where("cursos.user_id = ?", self.encuestado_id)
      @cant_encuestas = @enc_como_profesor.size
      @total_estrellas = @enc_como_profesor.sum("puntuacion")
      @reputacion_como_profesor = @total_estrellas / @cant_encuestas
      @reputacion.update_reputacion_profesor(@reputacion_como_profesor)

      @reputacion.upvote_recomendaciones(recomendado)

      #Calculo reputacion como Alumno
    else
      @enc_como_alumno =  Encuest.where("encuestado_id = ?" , self.encuestado_id).joins(:curso)
                          .where.not("cursos.user_id = ?", self.encuestado_id)
      @cant_encuestas = @enc_como_alumno.count
      @total_estrellas = @enc_como_alumno.sum("puntuacion")
      @reputacion_como_alumno = @total_estrellas / @cant_encuestas
      @reputacion.update_reputacion_alumno(@reputacion_como_alumno)
    end
  end

  def crear_cuest_alumno_a_profesor()
    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Asistencia a clases'
    @cuestionario.save

    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Puntualidad al llegar y retirarse de la clase'
    @cuestionario.save

    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Desarrolla todos los contenidos del curso'
    @cuestionario.save

    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Trata correctamente a los estudiantes (respeto, comunicación adecuada)'
    @cuestionario.save

    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Favorece la participación de los estudiantes'
    @cuestionario.save

    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Satisface dudas o consultas que surgen en la clase'
    @cuestionario.save

  end

  def crear_cuest_profesor_a_alumnos()
    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Integración del alumno'
    @cuestionario.save

    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Asistencia a clases'
    @cuestionario.save

    @cuestionario = Cuestionario.new
    @cuestionario.encuesta_id = self.id
    @cuestionario.pregunta = 'Trata correctamente al profesor y sus compañeros'
    @cuestionario.save
  end

end
