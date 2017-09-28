class NotificationsController < ApplicationController
  before_filter :require_login

  def index
    @notificaciones = Notification.where(:user_id => current_user.id).order(:created_at).reverse_order
    @notificaciones.each do |notificacion|
      notificacion.marcar_como_vista
    end
  end

  def ver
    @notificacion = Notification.find(params[:id])
    @notificacion.marcar_como_vista
    redirect_to @notificacion.link
  end
end
