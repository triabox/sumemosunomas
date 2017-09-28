class Curso < ActiveRecord::Base

  validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :fecha_inicio, presence: true
  validates :fecha_fin, presence: true
  validates :cupos, presence: true
  validates :contenido, presence: true
  validates :relacion_b_nb, numericality: { less_than: :cupos }
  validates :tipo_actividad, presence: true
  validates :location, presence: true
  validates :monto, presence: true

  has_many :clases, dependent: :destroy
  has_many :recursos_solicitados, class_name: "Recurso", dependent: :destroy
  has_many :alumnos_inscriptos, class_name: "Inscripto"
  belongs_to :location, dependent: :destroy , autosave: true, foreign_key: "location_id"

  belongs_to :user

  def crear_clases(horarios)
    i = 0
    claseNro = 1
    horarios.each_with_index do |hour,index|
      unless hour.to_s.empty?  or index.to_i > 6
        r = Montrose.weekly(on: i, until: self.fecha_fin, starts: self.fecha_inicio)
        r.events.each_with_index do |day|
          @clase = Clase.new
          @clase.curso_id = self.id
          @clase.nombre = "Clase " + (claseNro).to_s
          @clase.descripcion = ""
          @clase.contenido = ""
          @clase.fecha = day.to_s
          @clase.hora_inicio = hour
          @clase.hora_fin = horarios[index.to_i + 7].to_s
          @clase.save
          claseNro += 1
        end
        i += 1
      end
    end
  end

  def self.search(nombre,zona,tipo_actividad, fecha_inicio, fecha_fin, nombre_profesor)
    relation = where("publicado = ?", '1')
    relation = relation.where("finalizado = ?", '0')
    relation = relation.where("activo = ?", 'true')
    relation = relation.where("nombre iLIKE ? or contenido iLIKE ? or descripcion iLIKE ? ", "%#{nombre}%", "%#{nombre}%","%#{nombre}%")
                   .where("tipo_actividad iLIKE ?", "%#{tipo_actividad}%")
    relation = relation.where("fecha_inicio >= ?", fecha_inicio) if fecha_inicio.present?
    relation = relation.where("fecha_fin <= ?", fecha_fin) if fecha_fin.present?
    relation = relation.joins(:user).where("users.lastname iLIKE ?", "%#{nombre_profesor}%")
    relation = relation.joins(:location).where("locations.address iLIKE ?", "%#{zona}%")

    return relation
  end

  def listadoclases
    Curso.find(self.id).clases
  end

  def redondear_monto
    temp = self.monto.to_s.length
    sprintf("%#{temp}.2f",self.monto).to_s
  end

  def crear_recurso(recurso_params)
    @recurso = Recurso.new
    @recurso.curso_id = self.id
    @recurso.user_id = self.user_id
    @recurso.nombre = recurso_params[:nombre]
    @recurso.description = recurso_params[:description]
    @recurso.tipe = recurso_params[:tipe]
    @recurso.save
    @recurso
  end

  def inscribir(alumno, esBecado, type, pagado)
    @inscripto = Inscripto.new
    @inscripto.curso_id= self.id
    @inscripto.user_id= alumno.id
    @inscripto.tipe = type
    @inscripto.save

    #Crea una inscripcion por cada clase del curso
    @inscripto.crear_inscripciones(pagado)

    actualizar_cupos(esBecado)

    alumno.notificar_inscripcion_curso(self)
    self.user.notificar_profesor_inscripcion_alumno(self, alumno)

    # actualizo la reputación del alumno
    @reputacion = Reputacion.where(:user_id => alumno.id).first
    @reputacion.incrementar_cursos_inscriptos

    @inscripto
  end

  def reinscribir(inscripto, type)
    inscripto.tipe = type
    inscripto.payment_id = nil
    inscripto.save

    inscripto
  end

  def actualizar_cupos(esBecado)
    if esBecado
      self.relacion_b_nb = relacion_b_nb - 1;
    else
      self.cupos = cupos - 1;
    end
    self.save
  end

  def publicar
    update_attribute(:publicado, true)
  end

  def finalizar
    update_attribute(:finalizado, true)

    recursos_solicitados.each do |recurso|
      recurso.conseguir
      recurso.save
    end

    alumnos_inscriptos.each do |inscripto|
      @encuesta = crear_encuesta(inscripto.user_id, self.user_id)
      @encuesta.crear_cuest_profesor_a_alumnos

      @encuesta = crear_encuesta(self.user_id, inscripto.user_id)
      @encuesta.crear_cuest_alumno_a_profesor

      @user = User.find(inscripto.user_id)
      @user.notificar_finalizacion_curso(self)
    end
    @user = User.find(self.user_id)
    @user.notificar_finalizacion_curso(self)
  end

  def crear_encuesta(encuestado_id, encuestador_id)
    @encuesta = Encuest.new
    @encuesta.curso = self
    @encuesta.encuestado_id = encuestado_id
    @encuesta.encuestador_id = encuestador_id
    @encuesta.save
    @encuesta
  end

  def actualizo_reputacion_profesor
    @reputacion = Reputacion.where(:user_id => self.user_id).first
    @reputacion.incrementar_cursos_creados
  end

  def notificar_a_alumnos
    self.alumnos_inscriptos.each do |alumno|
      @user = User.find(alumno.user_id)
      @user.notificar_update_curso(self)
    end
  end

  def notificar_a_alumnos_eliminacion_curso
    self.alumnos_inscriptos.each do |alumno|
      @user = User.find(alumno.user_id)
      @user.notificar_eliminacion_curso(self)
    end
  end

  def actualizar_fechas
    clases = Clase.where(:curso_id => self.id).order(:fecha)
    self.assign_attributes(:fecha_inicio => clases.first.fecha, :fecha_fin => clases.last.fecha)
    if !self.publicado && self.changed?
      self.save
    end
  end
	
  def bajar_curso
    self.update(activo: false)
    self.bajar_recursos
    self.notificar_a_alumnos_eliminacion_curso
    self.save
  end

  def bajar_recursos
    self.recursos_solicitados.each do |recurso|
      recurso.conseguir
      recurso.save
    end
  end
end
