class Reputacion < ActiveRecord::Base
  belongs_to :user

  def upvote_recomendaciones(recomienda)
    if recomienda
      self.SUM_ProfesorRecomendado += 1
      self.save
    end
  end

  def update_reputacion_alumno(reputacion)
    self.update_attribute(:AVG_ReputacionAlumno, reputacion)
    self.save
  end

  def update_reputacion_profesor(reputacion)
    self.update_attribute(:AVG_ReputacionProfesor, reputacion)
    self.save
  end

  def incrementar_cursos_inscriptos
    self.SUM_CursosInscriptos += 1
    self.save
  end

  def incrementar_cursos_creados
    self.SUM_CursosCreados += 1
    self.save
  end

  def update_asistencia_a_clase(porcentaje)
    self.update_attribute(:PCT_AsistenciaAClases, porcentaje)
    self.save
  end
end
