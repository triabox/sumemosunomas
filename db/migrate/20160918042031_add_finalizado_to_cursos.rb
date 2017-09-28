class AddFinalizadoToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :finalizado, :boolean, default: false
  end
end
