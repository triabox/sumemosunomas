class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :nombre
      t.string :descripcion
      t.string :contenido
      t.string :lugar
      t.date :fecha_inicio
      t.date :fecha_fin
      t.integer :cupos
      t.integer :user_id
      t.integer :relacion_b_nb
      t.integer :user_id
      t.string :tipo_actividad
      t.timestamps null: false
    end
  end
end
