class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activación de cuenta"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Recupero contraseña"
  end

  def user_low_account(user)
    @user = user
    mail to: user.email, subject: "Desactivación Cuenta"
  end

  def enviar_notificacion(user, message,body)
    #message = "Felicitaciones! Se ha inscripto correctamente al curso: " + curso.nombre
    #message = "El alumno " + alumno.nameAndLastName + " se ha inscripto al curso: " + curso.nombre
    #message = "El curso " + curso.nombre + " ha sido eliminado."
    #message = "El curso " + curso.nombre + " ha finalizado, por favor conteste la encuesta."
    #message = curso.user.nameAndLastName + " te ha puntuado en la encuesta del curso: " + curso.nombre
    @body = body
    @user = user
    mail to: user.email, subject: message
  end

end
