class User < ActiveRecord::Base
  has_one :reputacion
  has_many :cursos_creados, foreign_key: "user_id", class_name: "Curso"
  has_many :encuestas_encuestado, foreign_key: "encuestado_id", class_name: "Encuest"
  has_many :encuestas_encuestador, foreign_key: "encuestador_id", class_name: "Encuest"
  has_many :cursos, class_name: Curso
  has_many :becados_por_fundacions, foreign_key: "fundacion_id", class_name: "BecadosPorFundacion"
  has_many :notifications, foreign_key:  "user_id", class_name: "Notification"
  has_one  :payment_type, class_name: "PaymentType"

  ROLES = %w[COMUN ADMIN FUNDACION].freeze

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  has_secure_password

  validates :name, presence: true, length: {maximum: 50}
  validates :lastname, length: {maximum: 80}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  validates :password, length: {minimum: 6}, presence: true, on: :create
  validates :active, length: {maximum: 2}

  belongs_to :location, dependent: :destroy, autosave: true, foreign_key: "location_id"

  has_many :sender_messages, class_name: 'Message'
  has_many :subject_messages, class_name: 'Message'

  mount_uploader :imagen, PhotoUploader


  include ApplicationHelper
  include SessionsHelper

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def update_location(location_params)
    if self.location.nil?
      self.location = Location.new
    end
    self.location.update_attributes(location_params)
    return self
  end

  def initialize_location
    if self.location.nil?
      self.location = Location.new
    end
    return self
  end

  def list_user_foundation
    return User.where("role = 'FUNDACION' and active = 1")
  end

  #Buscar Usuarios
  def self.search(search)
    where("role = :role and (LOWER(name) LIKE LOWER(:name)
                        or LOWER(lastname) LIKE LOWER(:lastname)
                        or LOWER(email) LIKE LOWER(:email)) and active = 1",
          {role: 'COMUN', name: "%#{search}%", lastname: "%#{search}%", email: "%#{search}%", })

  end

  #Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def nameAndLastname
    if self.lastname.nil?
      self.name
    else
      self.name + " " + self.lastname
    end
  end

  def user_image
    if self.imagen.present?
      self.imagen
    else
      "/avatar2.jpg"
    end
  end

  def notificar_inscripcion_curso(curso)
    @message = "Felicitaciones! Se ha inscripto correctamente al curso: " + curso.nombre
    @link = "/cursos/" + curso.id.to_s
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message)
  end

  def notificar_profesor_inscripcion_alumno(curso,alumno)
    @message = "El alumno " + alumno.nameAndLastname + " se ha inscripto al curso: " + curso.nombre
    @link = "/cursos/" + curso.id.to_s   #TODO: hacer que sea link a listado alumnos inscriptos a curso
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message,@message)
  end

  def notificar_finalizacion_curso(curso)
    @message = "El curso " + curso.nombre + " ha finalizado, por favor conteste la encuesta."
    @link = "/encuests/" + curso.id.to_s + "/edit?curso_id=" + curso.id.to_s
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message,@message)
  end

  def notificar_eliminacion_curso(curso)
    @message = "El curso " + curso.nombre + " fue eliminado, cualquier inconveniente puede consultar a profesor"
    @link = "/users/" + curso.user_id.to_s
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message,@message)
  end

  def notificar_alta_fundacion()
    @message ="Fundacion dada de alta"
    @body = "Fundacion dada de alta ya puede acceder a Sumemos Uno Mas"
    @link = "/users/" + self.id.to_s
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message,@body)
  end

  def notificar_update_curso(curso)
    @message = "El curso " + curso.nombre + " ha sido modificado."
    @link = "/cursos/" + curso.id.to_s
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message,@message)
  end

  def notificar_update_clase(clase)
    @message = "La clase " + clase.nombre + " del curso " + clase.curso.nombre + " ha sido modificada."
    @link = "/cursos/" + clase.curso.id.to_s
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message,@message)
  end

  def notificar_nueva_clase(clase)
    @message = "Se ha añadido una nueva clase al curso " + clase.curso.nombre
    @link = "/cursos/" + clase.curso.id.to_s
    Notification.crear_notificacion(self.id,@message, @link)
    UserMailer.enviar_notificacion(self, @message,@message)
  end

  def notificar_te_puntuaron(encuesta)
    @message = encuesta.encuestador.nameAndLastname + " te ha puntuado en la encuesta del curso: " + encuesta.curso.nombre
    @link = "/encuests/" + encuesta.curso.id.to_s + "/show?curso_id=" + encuesta.curso.id.to_s
    Notification.crear_notificacion(self.id,@message,@link)
    UserMailer.enviar_notificacion(self,@message,@message)
  end

  def get_encuestas
    Encuest.where(:encuestado_id => self.id).where(:completada => true)
  end

  def bajar_cursos
    self.cursos_creados.each do |curso|
      curso.bajar_curso
    end
  end

  def bajar_relacion_con_fundaciones
    BecadosPorFundacion.where(:becado_id => self.id).delete_all
  end


  def bajar_usuario
    if self.update(active: 0)
      UserMailer.user_low_account(self).deliver_now
      self.bajar_cursos
      self.bajar_relacion_con_fundaciones
      self.save
      return true
    end
    return false
  end
end