class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      if user && user.active  == 0
        flash.now[:danger] = 'El usuario se encuentra desactivado, comunicarse con el administrador del sistema'
        render 'new'
      elsif user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Cuenta no activada. "
        message += "Busca el link de activación en tus emails."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Email/contraseña inválidos'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end