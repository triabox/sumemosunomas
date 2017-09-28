class ReputacionController < ApplicationController

  def index
  end

  def show
    @reputacion = Reputacion.where(user => params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reputacion
    @user = User.find(params[:id])
  end

end
