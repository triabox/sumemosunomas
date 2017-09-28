class Cuestionario < ActiveRecord::Base
  belongs_to :encuest

  def completarCuestionario(cant_estrellas, respuesta)
    self.update_attribute(:cantEstrellas, cant_estrellas)
    self.update_attribute(:respuesta, respuesta)
    self.save
  end
end


