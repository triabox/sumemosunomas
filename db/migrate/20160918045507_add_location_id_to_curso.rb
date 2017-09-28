class AddLocationIdToCurso < ActiveRecord::Migration
  def change
    add_column :cursos, :location_id, :integer
  end
end
