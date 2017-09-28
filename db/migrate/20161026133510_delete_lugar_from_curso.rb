class DeleteLugarFromCurso < ActiveRecord::Migration
  def change
    remove_column :cursos, :lugar
  end
end
