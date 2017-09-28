class AddTiposDePagoToCurso < ActiveRecord::Migration
  def change
    add_column :cursos, :efectivo, :boolean, default: false
    add_column :cursos, :tarjeta, :boolean, default: false
  end
end
