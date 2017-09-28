class AddActiveToCurso < ActiveRecord::Migration
  def change

    add_column :cursos, :activo, :boolean, default: true
  end
end
