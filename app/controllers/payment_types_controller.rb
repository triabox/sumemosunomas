class PaymentTypesController < ApplicationController
  before_filter :require_permission, only: [:edit, :update, :destroy]

  def require_permission
    @payment_type = PaymentType.find(params[:id])
    if current_user != User.find(@payment_type.user_id)
      message = 'No tiene permiso para modificar el tipo de pago'
      flash[:danger] = message
      redirect_to root_url
    end
  end

  def new
    @payment_type = PaymentType.new
  end

  def create
    @payment_type = PaymentType.new(payment_type_params)
    @payment_type.user_id = current_user.id

    respond_to do |format|
      if (@payment_type.save)
        format.html { redirect_to current_user}
      else
        format.html { render :new }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @payment_type = PaymentType.find(params[:id])
  end

  def update
    @payment_type = PaymentType.find(params[:id])
    respond_to do |format|
      if @payment_type.update(payment_type_params)
        format.html { redirect_to current_user}
      else
        format.html { render :edit }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def payment_type_params
    params.require(:payment_type).permit(:name, :description, :tipe, :cuil, :cbu, :authorization,
                                         :merchant, :nombre, :apellido, :ciudad, :pais, :mail, :telefono, :cod_postal, :estado,
    :direccion, :moneda)
  end


end
