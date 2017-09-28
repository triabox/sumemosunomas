class AddPublicadoToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :publicado, :boolean, default: false
  end
end
