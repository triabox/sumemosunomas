class Inscripcion < ActiveRecord::Base
  belongs_to :inscripto, class_name: 'Inscripto', foreign_key: 'inscripto_id'
  belongs_to :clase, class_name: 'Clase', foreign_key: 'clase_id'


  def asistioAClase(asistio)
    update_attribute(:presencia,asistio)
    recalcularMiReputacion
  end

  def recalcularMiReputacion
    @inscripto = Inscripto.find(inscripto_id)
    @inscripto.marcarAsistenciaEnReputacionPara(self)
  end

end
