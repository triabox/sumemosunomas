class Clase < ActiveRecord::Base
  belongs_to :curso
  validate :validate_fecha_curso
  validates :hora_inicio, presence: true
  validates :hora_fin, presence: true
  validates :fecha, presence: true

  def notificar_a_alumnos(evento)
    self.curso.alumnos_inscriptos.each do |alumno|
      @user = User.find(alumno.user_id)
      if evento == 'update'
        @user.notificar_update_clase(self)
      else
        @user.notificar_nueva_clase(self)
      end
    end
  end

  private
  def validate_fecha_curso
    curso = Curso.find self.curso_id
    if curso.publicado and las_fechas_son_invalidas
      errors.add(:fecha, ': La clase debe darse entre la fecha de inicio y finalización del curso')
      false
    else
      true
    end
  end

  def las_fechas_son_invalidas
    !(self.fecha >= self.curso.fecha_inicio && self.fecha <= self.curso.fecha_fin)
  end

end
