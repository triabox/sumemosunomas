class Recurso < ActiveRecord::Base
  belongs_to :curso
  belongs_to :user

  validates :nombre,  presence: true, length: { maximum: 90 }
  validates :description,  presence: true, length: { maximum: 200 }
  validates :tipe, presence: true

  def conseguir
    update_attribute(:conseguido, true)
  end

  def self.search(nombre, nombre_profesor)

    relation = where("nombre iLIKE ? ", "%#{nombre}%")
    relation = relation.where("description iLIKE ? ", "%#{nombre}%")
    relation = relation.where("tipe iLIKE ? ", "%#{nombre}%")
    relation = relation.where conseguido:false

    return relation

  end

end
