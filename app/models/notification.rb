class Notification < ActiveRecord::Base
  belongs_to :users

  def self.crear_notificacion(user,message,path)
    @notificacion = Notification.create
    @notificacion.user_id = user
    @notificacion.mensaje = message
    @notificacion.link = path
    @notificacion.save
  end

  def marcar_como_vista
    self.update_attribute(:is_view, true)
  end
end
