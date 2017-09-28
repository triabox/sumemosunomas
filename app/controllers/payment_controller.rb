class PaymentController < ApplicationController

  def mark_payment
    @inscripto = Inscripto.find(params[:id])
    @inscripto.marcar_pagadas_inscripciones
    respond_to do |format|
      format.html { redirect_to @inscripto.curso}
    end
  end

  def mark_payment_todopago
    @payment = Payment.find(params[:id])
    @inscripto = Inscripto.find_by(payment_id: @payment.id)
    if(params[:status] == "OK")
      @payment.mark_payment
      @inscripto.marcar_pagadas_inscripciones
      message = "El pago se completo con exito"
      flash[:success] = message
    else
      message = "Fuiste inscripto correctamente pero hubo un error al procesar el pago - intente pagar nuevamente mas tarde"
      flash[:danger] = message
    end

    respond_to do |format|
      format.html { redirect_to @inscripto.curso}
    end
  end

  def open_todopago
    @payment = Payment.find(params[:id])
    @inscripto = Inscripto.find_by(payment_id: @payment.id)

    @response = @payment.open_todopago(current_user, @inscripto.curso);

    if(@response["envelope"]["body"]["send_authorize_request_response"]["status_code"] == "-1")
      redirect_to @response["envelope"]["body"]["send_authorize_request_response"]["url_request"]
    else
      message = @payment.description
      flash[:danger] = message
      redirect_to  edit_inscripto_path(@inscripto)
    end
  end

end
